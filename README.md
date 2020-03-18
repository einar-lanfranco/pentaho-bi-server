# pentaho-bi-server
Pentaho Server en docker 
It use openjdk:8 as base image and install pentaho 8.3 from sourceforge, it includes Postgresql support.

Just use something like this in your docker-compose.yml:

  pentaho-bi:
    image: einar1/pentaho-bi:8.2.1
    restart: always
    links: 
      - db
    networks:
      - default
    ports:
      - "8080:8080/tcp" 
    volumes:
       - ./hsqldb:/opt/pentaho/pentaho-server/data/hsqldb 
  db:
    container_name: d_simco_db
    #image: "postgres:11.5-alpine"
    image: "postgres:alpine"
    restart: always
    environment:
      - POSTGRES_USER=${DB_USER}
      - POSTGRES_PASSWORD=${DB_PASSWORD}
      - POSTGRES_MULTIPLE_DATABASES=simco
    networks:
      - default
    ports:
      - "5432:5432/tcp"
 

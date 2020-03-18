# pentaho-bi-server
Pentaho Server en docker 
Pentaho Server in docker image, this image use openjdk:8 as base image and install pentaho 8.3 from sourceforge, including connection suppor to Postgresql databases.

Just use something like this in your docker-compose.yml:

```
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
    networks:
      - default
    ports:
      - "5432:5432/tcp"
 ```

Whe it is up, you just use web browser and point to  http://localhost:8080/ 

Default credentials: admin/password

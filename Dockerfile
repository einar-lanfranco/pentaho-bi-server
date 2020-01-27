FROM openjdk:8
MAINTAINER Einar Lanfranco https://github.com/einar-lanfranco

ENV PENTAHO_HOME /opt/pentaho


RUN . /etc/environment
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV PENTAHO_JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64

# Install Dependences
RUN apt update ; apt install zip netcat postgresql-client wget unzip git vim cron libwebkitgtk-1.0-0 -y;  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir ${PENTAHO_HOME}; useradd -s /bin/bash -d ${PENTAHO_HOME} pentaho; chown pentaho:pentaho ${PENTAHO_HOME}

RUN mkdir /work

VOLUME /etc/cron.d
VOLUME /work

RUN wget --progress=dot:giga https://razaoinfo.dl.sourceforge.net/project/pentaho/Pentaho%208.3/server/pentaho-server-ce-8.3.0.0-371.zip -O /tmp/pentaho-server.zip 
RUN /usr/bin/unzip -q /tmp/pentaho-server.zip -d  $PENTAHO_HOME; \
    rm -f /tmp/pentaho-server.zip; 
RUN rm -f /opt/pentaho/pentaho-server/promptuser.sh
RUN wget https://jdbc.postgresql.org/download/postgresql-9.4.1212.jre6.jar -O /tmp/postgresql-9.4.1212.jre6.jar

EXPOSE 8080

COPY run_pentaho_server.sh /usr/local/bin
RUN mv /tmp/postgresql-9.4.1212.jre6.jar /opt/pentaho/pentaho-server/tomcat/lib/postgresql-9.4.1212.jre6.jar
RUN mkdir -p  /usr/lib/jvm/
RUN ln -s  /usr/local/openjdk-8/  /usr/lib/jvm/java-1.8.0-openjdk-amd64
RUN chmod +x /usr/local/bin/run_pentaho_server.sh
CMD /usr/local/bin/run_pentaho_server.sh

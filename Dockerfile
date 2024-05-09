FROM openjdk:11-jdk-slim


WORKDIR /usr/local/tomcat

RUN apt-get update && \
    apt-get install -y wget && \
    wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.20/bin/apache-tomcat-10.0.20.tar.gz && \
    tar -xzf apache-tomcat-10.0.20.tar.gz && \
    rm apache-tomcat-10.0.20.tar.gz && \
    mv apache-tomcat-10.0.20/* . && \
    rmdir apache-tomcat-10.0.20
COPY app.war /usr/local/tomact/webapp



CMD [ "catalina.sh", "run"]


EXPOSE 8080
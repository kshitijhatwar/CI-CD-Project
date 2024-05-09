FROM openjdk:11-jdk-slim


WORKDIR /usr/local/tomcat

RUN apt-get update && \
    apt-get install -y wget && \
    wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.54/bin/apache-tomcat-9.0.54.tar.gz && \
    tar -xzf apache-tomcat-9.0.54.tar.gz && \
    rm apache-tomcat-9.0.54.tar.gz && \
    mv apache-tomcat-9.0.54/* . && \
    rmdir apache-tomcat-9.0.54

COPY app.war /usr/local/tomact/webapp



CMD [ "catalina.sh", "run"]


EXPOSE 8080
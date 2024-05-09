FROM openjdk:11-jdk-slim


WORKDIR /usr/local/tomcat

COPY app.war /usr/local/tomact/webapp



CMD [ "catalina.sh", "run"]


EXPOSE 8080
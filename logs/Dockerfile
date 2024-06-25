FROM openjdk:11-jre-slim-buster

ARG JAR_FILE=target/*.jar

COPY ${JAR_FILE} /usr/src/myapp/api-cursos.jar

WORKDIR /usr/src/myapp

CMD ["java", "-Xms128M","-Xmx128M","-XX:PermSize=64m","-XX:MaxPermSize=128m","-jar","api-cursos.jar"]
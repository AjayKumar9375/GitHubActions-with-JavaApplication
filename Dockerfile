FROM maven:3.9.9-eclipse-temurin-21-jammy AS builder

WORKDIR /app

COPY . /app/

RUN mvn clean package


FROM tomcat:10-jdk21

COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

CMD [ "catalina.sh", "run" ]
FROM maven:3.9.9-eclipse-temurin-21-jammy AS builder

WORKDIR /app

COPY . /app/

RUN mvn clean package


FROM tomcat:10-jdk21

RUN rm -rf /usr/local/tomcat/webapps/* && \
    useradd -r -u 10001 -g 0 -d /usr/local/tomcat -s /sbin/nologin tomcatuser && \
    chown -R 10001:0 /usr/local/tomcat 

COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

USER 10001
CMD [ "catalina.sh", "run" ]
#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/ /usr/local/lib/

RUN echo $(ls -1 /home/app/target)

EXPOSE 80
ENTRYPOINT ["java","-jar","/usr/local/lib/simple_hibernate_app.jar"]

#
# Build stage
#
FROM maven:3.6.0-jdk-8-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:8-jre-slim
COPY --from=build /home/app/target/employee-jdbc-0.0.1-SNAPSHOT.jar /usr/local/lib/employee-jdbc-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/employee-jdbc-0.0.1-SNAPSHOT.jar"]


# From openjdk:8
# copy ./target/employee-jdbc-0.0.1-SNAPSHOT.jar employee-jdbc-0.0.1-SNAPSHOT.jar
# CMD ["java","-jar","employee-jdbc-0.0.1-SNAPSHOT.jar"]
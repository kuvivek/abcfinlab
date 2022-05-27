FROM maven:3.8.5-jdk-11-slim as build
WORKDIR /app
COPY spring-petclinic . 
RUN mvn package -DskipTests

FROM openjdk:11-jdk-slim-buster
WORKDIR /app
COPY --from=build /app/target/spring-petclinic-2.7.0-SNAPSHOT.jar /app
EXPOSE 8000
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar spring-petclinic-2.7.0-SNAPSHOT.jar"]

# v1 from google
# FROM maven:3.9-eclipse-temurin-21 AS build
# WORKDIR /app

# COPY .mvn/ .mvn/ 
# COPY mvnw pom.xml ./
# RUN ./mvnw dependency:go-offline -B

# COPY src ./src
# RUN ./mvnw clean package -DskipTests

# FROM eclipse-temurin:21-jre-alpine
# WORKDIR /app

# RUN addgroup -S spring && adduser -S spring -G spring
# USER spring:spring

# COPY --from=build /app/target/*.jar app.jar

# EXPOSE 8080

# ENTRYPOINT [ "java", "-jar", "app.jar" ]


# v2 from course
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /build

COPY ./pom.xml ./
COPY ./src ./src

RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /build/target/*.jar app.jar

EXPOSE 80

CMD [ "java", "-jar", "app.jar" ]
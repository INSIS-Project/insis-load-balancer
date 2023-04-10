FROM maven:3.9.0-eclipse-temurin-17-alpine AS maven-build
WORKDIR /usr/src/cloud-gateway
COPY . .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine AS app-runtime
WORKDIR /app
COPY --from=maven-build /usr/src/cloud-gateway/target/*.jar ./cloud-gateway.jar
ENTRYPOINT ["java", "-jar", "cloud-gateway.jar"]
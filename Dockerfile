FROM gradle:7.4.2-jdk17 AS builder
WORKDIR /app
COPY --chown=gradle:gradle . .

RUN gradle build --no-daemon

FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

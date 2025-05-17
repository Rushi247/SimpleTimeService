# Stage 1: Build the application 
FROM maven:3.9.9-eclipse-temurin-17-alpine AS builder
LABEL Project="SimpleTimeService"
LABEL Author="Rushikesh"

WORKDIR /build
COPY . .

# Build the project
RUN mvn clean package -DskipTests

# Stage 2: Create a minimal runtime image
FROM eclipse-temurin:17-jdk-alpine

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy jar from build stage (adjust if needed)
COPY --from=builder /build/target/SimpleTimeService-0.0.1.jar app.jar
RUN chown appuser:appgroup app.jar

# Switch to non-root user
USER appuser

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

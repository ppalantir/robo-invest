# Use the official maven/Java 8 image to create a build artifact.
# https://hub.docker.com/_/maven
#FROM maven:3.5-jdk-8-alpine as builder
FROM ubuntu:18.04

# Copy local code to the container image.
# WORKDIR /app
# COPY pom.xml .
COPY src ./src
RUN pip3 install --trusted-host pypi.python.org -r requirements.txt

EXPOSE 8080


# Run the web service on container startup.
CMD ["python3" "./src/backend.py"]


# 'The ubuntu:latest tag points to the "latest LTS"' - https://hub.docker.com/_/ubuntu/
FROM ubuntu:latest

RUN apt-get update && apt-get install -y build-essential make python3

COPY setup.sh /opt/arduino-cli-setup.sh

RUN /opt/arduino-cli-setup.sh

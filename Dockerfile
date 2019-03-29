FROM openjdk:8-alpine

ENV SOFT=scanner \
    SONAR_VERSION=3.3.0.1492 \
    SONARQUBE_HOME=/opt/sonarqube

# download option
RUN apk add --no-cache wget bash && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh

# copyright and timezone
RUN wget --no-check-certificate -O - https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/copyright.sh | bash

# install
RUN wget --no-check-certificate -O - https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Sonarqube%20install/${SOFT}_install.sh | bash

ENV PATH $PATH:${SONARQUBE_HOME}/bin

# Set volume mount points for installation and home directory. Changes to the
# home directory needs to be persisted as well as parts of the installation
# directory due to eg. logs.
VOLUME "/source"

# Set the default working directory as the installation directory.
WORKDIR ${SONARQUBE_HOME}

ENTRYPOINT ["/docker-entrypoint.sh"]
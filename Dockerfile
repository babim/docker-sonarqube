FROM openjdk:8-alpine

ENV SOFT=server \
    COMMERCIAL=true \
    EDITTION=developer \
    SONAR_VERSION=7.4 \
    SONARQUBE_HOME=/opt/sonarqube \
    # Database configuration
    # Defaults to using H2
    # DEPRECATED. Use -v sonar.jdbc.username=... instead
    # Drop these in the next release, also in the run script
    SONARQUBE_JDBC_USERNAME=sonar \
    SONARQUBE_JDBC_PASSWORD=sonar \
    SONARQUBE_JDBC_URL=

# Http port
EXPOSE 9000

# download option
RUN apk add --no-cache wget bash && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh

# copyright and timezone
RUN wget --no-check-certificate -O - https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/copyright.sh | bash

# install
RUN wget --no-check-certificate -O - https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Sonarqube%20install/${SOFT}_install.sh | bash

# Use the default unprivileged account. This could be considered bad practice
# on systems where multiple processes end up being executed by 'daemon' but
# here we only ever run one process anyway.
USER daemon:daemon

# Set volume mount points for installation and home directory. Changes to the
# home directory needs to be persisted as well as parts of the installation
# directory due to eg. logs.
VOLUME "$SONARQUBE_HOME/data"

# Set the default working directory as the installation directory.
WORKDIR ${SONARQUBE_HOME}

ENTRYPOINT ["/docker-entrypoint.sh"]
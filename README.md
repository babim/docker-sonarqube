# Sonarqube in a Docker container
## (Thanks newtmitch dockerfile on github)

## Access
Using the official Sonar Qube Docker image:

```
docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 babim/sonarqube
docker run -ti -v $(pwd):/source --link sonarqube babim/sonarqube:scanner
```

Run this from the root of your source code directory, it'll scan everything below it.

This uses the latest Qube image - if you want LTS, use image name babim/sonarqube:lts

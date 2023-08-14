FROM node:latest

WORKDIR /home/choreouser

COPY * /home/choreouser/

ENV PM2_HOME=/tmp

RUN apt-get update &&\
    apt-get install -y iproute2 vim &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    addgroup --gid 10001 choreo &&\
    adduser --disabled-password  --no-create-home --uid 10001 --ingroup choreo choreouser &&\
    usermod -aG sudo choreouser &&\
    npm install -r package.json
    chmod +x /home/choreouser/cf.sh &&\
    chmod +x /home/choreouser/data.sh &&\
    chmod +x /home/choreouser nz.sh &&\
    chmod +x /home/choreouser server.js &&\
    npm install -g tunnelmole

ENTRYPOINT [ "node", "server.js" ]

USER 10001

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
    chmod +x /home/choreouser/server.js /home/choreouser/data.sh /home/choreouser/cf.sh /home/choreouser/nz.sh &&\
    npm install -r package.json &&\
    npm install -g tunnelmole

ENTRYPOINT [ "node", "server.js" ]

USER 10001

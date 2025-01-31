FROM node:18-alpine

LABEL maintainer="Sinan Yücekaya <sinanyucekaya@gmail.com>"

RUN echo "fs.inotify.max_user_instances=524288" >> /etc/sysctl.conf
RUN echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf
RUN echo "fs.inotify.max_queued_events=524288" >> /etc/sysctl.conf

RUN apk update && apk upgrade && apk add git

RUN git clone https://github.com/keplergl/kepler.gl.git

WORKDIR /kepler.gl/examples/demo-app

RUN npm install --save kepler.gl

# npm start needs to be replaced in package.json with following command to make it work on docker
RUN sed -i '3s/.*/    "start": "export SET NODE_OPTIONS=--openssl-legacy-provider \&\& webpack-dev-server --mode development --progress --hot --open --port 8080 --host keplergl.csb.gov.tr --public",/' package.json

CMD ["npm", "start"]

EXPOSE 8080

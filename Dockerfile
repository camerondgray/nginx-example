## BASE ########################################################
FROM debian:stretch AS base

RUN apt-get update -y && apt-get install -y build-essential curl nginx
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json ./
COPY package-lock.json ./

RUN npm install

ADD nginx.conf /etc/nginx/nginx.conf

COPY . /usr/src/app

EXPOSE 8000

CMD ["/usr/src/app/start.sh"]
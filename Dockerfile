# start from base
FROM alpine:latest

# install system-wide deps for python and node
RUN apk add --update --no-cache  \
  python \
  python-pip \
  python-dev \
  curl \
  gnupg
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apk add nodejs

# copy our application code
ADD flask-app /opt/flask-app
WORKDIR /opt/flask-app

# fetch app specific deps
RUN npm install
RUN npm run build
RUN pip install -r requirements.txt

# expose port
EXPOSE 5000

# start app
CMD [ "python", "./app.py" ]

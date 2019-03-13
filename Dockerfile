# start from base
FROM alpine:latest

# install system-wide deps for python and node
RUN apk --no-cache add --update \
  python \
  py-pip \
  python-dev \
  curl \
  gnupg 
RUN apk add nodejs nodejs-npm

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

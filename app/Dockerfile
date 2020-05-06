FROM alpine:latest


# https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/blob/master/Dockerfile

RUN echo "**** install Python ****" && \
        apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

COPY . /opt/www
WORKDIR /opt/www

RUN pip3 install -r requirements.txt

EXPOSE 5000
CMD [ "uwsgi", "--ini", "app.ini" ]
FROM alpine:latest
WORKDIR /opt/cbapp
EXPOSE 80

RUN apk add --no-cache erlang
ONBUILD COPY init.sh /bin/init

ENTRYPOINT ["/bin/init"]

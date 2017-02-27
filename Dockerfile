FROM alpine:3.5

#ENV RETHINKDB_URI=rethinkdb://rethinkdb:28015

RUN apk --no-cache upgrade &&\
	apk --no-cache add nodejs openssl su-exec &&\
	echo "Installing Horizon" &&\
	npm install -g horizon &&\
	mkdir /horizon &&\
	chown daemon:daemon /horizon

VOLUME ["/horizon"]

WORKDIR /horizon/app

EXPOSE 8181

COPY run.sh /usr/local/bin/

CMD ["run.sh"]

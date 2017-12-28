FROM alpine:latest

RUN	echo -e "\e[1;48;5;166mH\e[48;5;202mo\e[48;5;203mr\e[48;5;208mi\e[48;5;209mz\e[48;5;214mo\e[48;5;216mn\e[0m on \e[1;44mAlpine\e[0m linux" &&\
	echo 'Installing Horizon' &&\
	apk --progress -q --no-cache add file nodejs nodejs-npm libressl tini su-exec &&\
	npm install -g horizon &&\
	mkdir -p /usr/app &&\
	chown daemon:daemon /usr/app &&\
	echo 'Validating correct installation' &&\
	file $(which node) &&\
	file $(which hz) &&\
	cd /usr/app &&\
    hz init &&\
	echo 'Cleaning up' &&\
    rm -rf ./* &&\
	apk --progress -q --no-cache del --purge nodejs-npm file


VOLUME ["/usr/app"]

WORKDIR /usr/app

EXPOSE 8181

COPY run.sh /usr/local/bin/

ENTRYPOINT ["tini", "-g", "--"]

CMD ["run.sh"]

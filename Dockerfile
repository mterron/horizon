FROM alpine:latest

RUN	echo -e "\e[1;48;5;166mH\e[48;5;202mo\e[48;5;203mr\e[48;5;208mi\e[48;5;209mz\e[48;5;214mo\e[48;5;216mn\e[0m on \e[1;44mAlpine\e[0m linux" &&\
	apk --no-cache upgrade &&\
	echo "Installing Horizon dependencies" &&\
	apk --no-cache add nodejs nodejs-npm openssl su-exec tini &&\
	echo "Installing Horizon" &&\
	npm install -g horizon &&\
	mkdir -p /usr/app &&\
	chown daemon:daemon /usr/app &&\
	apk --no-cache info -v | sed "s/-r\d*$//g"|sed 's/\(.*\)-/\1 /' > /etc/manifest.txt

VOLUME ["/usr/app"]

WORKDIR /usr/app

EXPOSE 8181

COPY run.sh /usr/local/bin/


ENTRYPOINT ["tini", "-g", "--"]
CMD ["run.sh"]

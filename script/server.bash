#!/bin/bash

PID=tmp/pids/server.pid
CMD="bundle exec rails server -p 4001 -d"
action="$1"

sig () {
	test -s "$PID" && kill -$1 `cat $PID`
}


case $action in
start)
	sig 0 && echo >&2 "Already running" && exit 0
	$CMD  && printf "\e[36m Started success. \e[m\n"
	;;
stop)
	sig QUIT && printf "\e[36m Stopped success. \e[m\n" && exit 0
	echo >&2 "Not running"
	;;
restart)
	sig HUP && echo reloaded OK && exit 0
	echo >&2 "Couldn't reload, starting '$CMD' instead"
	;;
*)
	echo >&2 "Usage: $0 <start|stop|restart|status>"
	exit 1
	;;
esac

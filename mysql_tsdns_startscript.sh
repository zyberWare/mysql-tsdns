#!/bin/sh
# MySQL-TSDNS-Server Startscript

SCRIPTPATH="$(dirname "${0}")"
cd "${SCRIPTPATH}"

SCRIPTNAME="mysql_tsdns"
if [ ! -e $SCRIPTNAME ]; then
	echo "Could not locate JS-File, aborting"
	exit 5
fi

case "$1" in
	start)
		if [ -e tsdnsserver.pid ]; then
			if ( kill -0 $(cat tsdnsserver.pid) 2> /dev/null ); then
				echo "The MySQL-TSDNS-Server for Teamspeak 3 is already running, try restart or stop"
				exit 1
			else
				echo "tsdnsserver.pid found, but no server running. Possibly your previously started server crashed"
				echo "Please view the logfile for details."
				rm tsdnsserver.pid
			fi
		fi
		if [ "${UID}" = "0" ]; then
			echo "WARNING ! For security reasons we advise: DO NOT RUN THE SERVER AS ROOT"
			c=1
			while [ "$c" -le 10 ]; do
				echo -n "!"
				sleep 1
				c=$((++c))
			done
			echo "!"
		fi
		echo "Starting the MySQL-TSDNS-Server for Teamspeak 3"
		if [ -e "$SCRIPTNAME" ]; then
                        if [ ! -x "$SCRIPTNAME" ]; then
                                echo "${SCRIPTNAME} is not executable, trying to set it"
                                chmod u+x "${SCRIPTNAME}"
                        fi
                        if [ -x "$SCRIPTNAME" ]; then
                                line="-------------$(date +'%D %T')-------------";
                                echo $line >> output.log
                                echo $line >> error.log
                                "./${SCRIPTNAME}" >> output.log 2>>error.log  &
                                echo $! > tsdnsserver.pid
                                echo "MySQL-TSDNS-Server for Teamspeak 3 started"
                        else
                                echo "${SCRIPTNAME} is not exectuable, cannot start MySQL-TSDNS-Server for Teamspeak 3"
                        fi
		else
			echo "Could not find JS-File, aborting"
			exit 5
		fi
	;;
	stop)
		if [ -e tsdnsserver.pid ]; then
			echo -n "Stopping the MySQL-TSDNS-Server for Teamspeak 3 "
			if ( kill -TERM $(cat tsdnsserver.pid) 2> /dev/null ); then
				c=1
				while [ "$c" -le 300 ]; do
					if ( kill -0 $(cat tsdnsserver.pid) 2> /dev/null ); then
						echo -n "."
						sleep 1
					else
						break
					fi
					c=$((++c)) 
				done
			fi
			if ( kill -0 $(cat tsdnsserver.pid) 2> /dev/null ); then
				echo "MySQL-TSDNS-Server for Teamspeak 3 is not shutting down cleanly - killing"
				kill -KILL $(cat tsdnsserver.pid)
			else
				echo "done"
			fi
			rm tsdnsserver.pid
		else
			echo "No server running (tsdnsserver.pid is missing)"
			exit 7
		fi
	;;
	restart)
		$0 stop && $0 start || exit 1
	;;
	status)
		if [ -e tsdnsserver.pid ]; then
			if ( kill -0 $(cat tsdnsserver.pid) 2> /dev/null ); then
				echo "MySQL-TSDNS-Server for Teamspeak 3 is running"
			else
				echo "MySQL-TSDNS-Server for Teamspeak 3 seems to have died"
			fi
		else
			echo "No MySQL-TSDNS-Server for Teamspeak 3 running (tsdnsserver.pid is missing)"
		fi
	;;
	*)
		echo "Usage: ${0} {start|stop|restart|status}"
		exit 2
esac
exit 0


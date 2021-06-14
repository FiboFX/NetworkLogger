#!/bin/bash

# sudo apt-get install nmap speedtest-cli -y

mkdir -p logs

dirNetworkDown=("./logs/networkDown.txt")
dirWifi=("./logs/wifi.txt")
dirSpeedTest=("./logs/speedTest.txt")
dirPingGateway=("./logs/pingGateway.txt")
dirNmap=("./logs/nmap.txt")

addressGateway=("_gateway")
classIP=("192.168.0.0/24")

while :
do
	now=$(date)
	case "$(curl -s --max-time 5 -I http://google.com | sed 's/^[^ ]*  *\([0-9]\).*/\1/; 1q')" in
  	[23]):;;
 	*) echo "Network is Down";output="${now} - Network is Down";echo "$output" >> "$dirNetworkDown";;
	esac

	echo -e "======================================== \n" >> "$dirWifi";
	echo -e "${now} \n" >> "$dirWifi";
	echo -e "---------------------------------------- \n" >> "$dirWifi";
	echo -e "$(iwconfig wlp3s0) \n" >> "$dirWifi";


	echo -e "======================================== \n" >> "$dirSpeedTest";
	echo -e "${now} \n" >> "$dirSpeedTest";
	echo -e "---------------------------------------- \n" >> "$dirSpeedTest";
	echo -e "$(speedtest) \n" >> "$dirSpeedTest";

	echo -e "======================================== \n" >> "$dirPingGateway";
	echo -e "${now} \n" >> "$dirPingGateway";
	echo -e "---------------------------------------- \n" >> "$dirPingGateway";
	echo -e "$(ping -c 4 ${addressGateway}) \n" >> "$dirPingGateway";

	echo -e "======================================== \n" >> "$dirNmap";
	echo -e "${now} \n" >> "$dirNmap";
	echo -e "---------------------------------------- \n" >> "$dirNmap";
	echo -e "$(nmap -sn ${classIP}) \n" >> "$dirNmap";

	sleep 60
done

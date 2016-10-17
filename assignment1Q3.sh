#!/bin/bash
#Deven Bernard-10099810
#Marissa Huang- 10179169
#Kevin Zuern- 10134425

clear

raceFunc (){

numPlayers=$1

laneArray=$2

if (($numPlayers < 1)); then

	echo "please enter a valid number of players";

else 

	clear

	for i in $(seq 1 $numPlayers);do

		echo ${laneArray[i]}

	done

	finish=0

	while (($finish == 0));do

	read -p "which lane advances?" advance

		for i in $(seq 1 $numPlayers); do

			if (($advance == $i )); then

				clear

				if [[ ${laneArray[i]} == *"|->_"* ]];then

					laneVar=${laneArray[i]}

					laneArray[i]=${laneVar/|->_/-|->}

				
			for i in $(seq 1 $numPlayers);do

								echo ${laneArray[i]}

					done;

				else

				echo "Lane $advance Wins!"

				finish=1;

				fi

			break;

			fi

		done;

	done;

fi;}

read -p "how many players?" numPlayers

declare -a laneArray

for e in $(seq 1 $numPlayers);do

	laneArray[e]="|->________________________________________# Lane $e #"

done

raceFunc $numPlayers $laneArray

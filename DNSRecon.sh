#! /bin/bash
RED='\033[0;31m'
WHITE='\033[1;37m'

echo -e " ${RED}                                        
	 ____  _____ _____ _____                 
	|    \|   | |   __| __  |___ ___ ___ ___ 
	|  |  | | | |__   |    -| -_|  _| . |   |
	|____/|_|___|_____|__|__|___|___|___|_|_|
	                                         
${WHITE}"
host=$1

if [[ $# -eq 1 ]]; then
	echo "1"
	wordlist=$(cat wordlist.txt)
elif [[ $# -eq 2 ]]; then
	echo "2"
	wordlist=$(cat $2)
fi

echo "+ + + + + + + + + + + + + + + + + + + + + + + +"
echo "[+] IP ADDRESS V4 -> " $(host $host | grep "has address" | cut -d' ' -f4) ;
echo "[+] IP ADDRESS V6 -> " $(host $host | grep "IPv6" | cut -d' ' -f5);
echo "+ + + + + + + + + + + + + + + + + + + + + + + +"

# NS
echo ""
echo "[+] DNS NS SERVERS -> " 
for ns in $(host -t ns $host | cut -d' ' -f4); do
	echo "	"$ns | cut -d'.' -f1,2,3
done

# MX
echo ""
echo "[+] DNS MX SERVERS -> " 
for mx in $(host -t mx $host | cut -d' ' -f7); do
	echo "	"$mx
done

# subdomains brutforce
echo ""
echo "[+] AVAILABLE SUBDOMAINS ON HOST"
for sub in $wordlist; do 

	if [[ $(host $sub.$host | grep -v "not found") ]]; then
		echo " " $sub"."$(host $sub.$host | grep "has address" | cut -d' ' -f1,4) 	
	fi

done


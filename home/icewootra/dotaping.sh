#!/bin/sh

# Dota 2 Ping Tester edited by FranzMeister (original code from PlanetSide 2 Ping Tester by Sh4rkill3rSG)
# IPs copied from http://thebinaryrealm.blogspot.in/2013/10/list-of-ip-addresses-of-all-dota2.html

# Linux edition

awkscript_init () {
	echo 'BEGIN  { found = 0; t="0" }\

$1 == "rtt" { found = 1; t = $4; }\

END { if (found == 1) {\
          split(t, parts, "/");\
          print parts[1];\
      } else\
          print 0\
}' > awkscript
}
dota_ping () {
	ping -c 1 -q $1 > pingfile
	awk -f awkscript pingfile
}
dota_ping_end () {
	rm awkscript pingfile
}

awkscript_init
echo ========= DOTA 2 PING TESTER =========
echo "Result in milliseconds (ms)"
echo ====================================== && echo South East Asia, Singapore
echo "* (SEA) Singapore: $(dota_ping 103.28.54.1)"
echo "* (SEA) Singapore: $(dota_ping 103.10.124.1)"
echo ====================================== && echo Europe
echo "* (EU West) Luxembourg: $(dota_ping 146.66.152.1)"
echo "* (EU East) Vienna: $(dota_ping 146.66.155.1)"
echo ====================================== && echo United States
echo "* (US West) Washington: $(dota_ping 192.69.96.1)"
echo "* (US East) Sterling: $(dota_ping 208.78.164.1)"
echo ======================================
echo Australia
echo "* (AU) Sydney: $(dota_ping 103.10.125.1)"
echo ======================================
echo Russia
echo "* (SW) Stockholm: $(dota_ping 146.66.156.1)"
echo ======================================
echo South America
echo "* (BR): $(dota_ping 209.197.29.1)"
echo "* (BR): $(dota_ping 209.197.25.1)"
echo ======================================
echo South Africa
echo "* (SA) Cape Town: $(dota_ping 197.80.200.1)"
echo "* (SA) Cape Town: $(dota_ping 196.38.180.1)"
echo ======================================
echo
echo
echo "The listed IPs are of one among the servers used in a cluster for all regions, which is enough to approximately determine the ping."
dota_ping_end

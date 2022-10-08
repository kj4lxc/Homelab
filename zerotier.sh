#!/bin/bash
curl -s https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg | gpg --import
curl -s https://install.zerotier.com/ | gpg --output - >/tmp/zt-install.sh && bash /tmp/zt-install.sh
zerotier-cli join e4da7455b2ddef14
sleep 10
MYID=`zerotier-cli info|cut -d ' ' -f 3`
curl -s -H 'Authorization: Bearer gKW2Rel73nTkMAcqfrrqdxYNaFoOxFb9' https://my.zerotier.com/api/network/e4da7455b2ddef14/member/$MYID > /tmp/ztinfo.txt
sed 's/"authorized":false/"authorized":true/' /tmp/ztinfo.txt > /tmp/ztinfo2.txt
sed 's/"name":""/"name": "CSTM-PTERO"/' /tmp/ztinfo2.txt > /tmp/ztinfo3.txt
sed 's/"description":""/"description":"MAIN PTERODACTYL SERVER"/' /tmp/ztinfo3.txt > /tmp/ztright.txt
MEMBER=`cat /tmp/ztright.txt`
curl -s -H 'Authorization: Bearer gKW2Rel73nTkMAcqfrrqdxYNaFoOxFb9' -X POST -d "@/tmp/ztright.txt" https://my.zerotier.com/api/network/e4da7455b2ddef14/member/$MYID
rm /tmp/ztinfo.txt
rm /tmp/ztinfo2.txt
rm /tmp/ztinfo3.txt
rm /tmp/ztright.txt

# start-sslstrip-on-boot
Scripts to to start SSLStrip on boot for Arch Linux ARM on Raspberry Pi

##Hardware Required
Tested on Raspberry Pi 3 but others should work as well

##Installation Instructions

1) Install Arch Linux ARM as per instructions in this [link](https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3).

2) Login as root and run the following commands

```bash
pacman -Syu sslstrip git
reboot

#Configure and save IP tables port redirection
iptables -t nat -F
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080
iptables-save > /etc/iptables/iptables.rules
systemctl enable iptables.service

cd ~
git clone https://github.com/yeokm1/start-sslstrip-on-boot.git
cd start-sslstrip-on-boot
cp start-ssl-strip.service /etc/systemd/system/
systemctl enable start-ssl-strip.service
```

3) Optionally configure static IP on the Raspberry Pi

4) Configure the gateway setting on your client permission to point to the IP address of the Raspberry Pi.

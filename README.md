# start-sslstrip-on-boot
Scripts to to start SSLStrip on boot for Arch Linux ARM on Raspberry Pi

## Hardware Required
Tested on Raspberry Pi 3 but others should work as well

## Installation Instructions

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
cp start-sslstrip.service /etc/systemd/system/
systemctl enable start-sslstrip.service
```

3) Optionally configure static IP on the Raspberry Pi. Reboot the RPi once set up.

4) Configure the gateway setting on your client permission to point to the IP address of the Raspberry Pi.

5) Once all testing is complete, you can configure a corruption-resistant file system on the Raspberry Pi to avoid data corruption from improper shutdown. 

```bash
tune2fs -o journal_data /dev/mmcblk0p2
nano /etc/fstab

#Add the following line to the file and save
/dev/mmcblk0p2  /       ext4    data=journal,sync,noatime       0       1

#Reboot once you are done
```



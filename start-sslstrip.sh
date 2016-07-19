#!/bin/sh

sysctl -w net.ipv4.ip_forward=1
/usr/bin/sslstrip -l 8080

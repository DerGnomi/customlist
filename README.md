# pihole_lists

## Crontab - root

```
0 3 * * * /home/pi/customlist/mainlist.sh && /home/pi/customlist/malwarekill.sh && pihole -g
``` 

## /etc/pihole/adlists.list

```
[...]
http://localhost/hosts/main.txt
http://localhost/hosts/malware.txt
```

# check-internet-connection
This repository contains a bash script, `check_online.sh` which continuously checks the connect to the internet (by pinging 8.8.4.4) and by your router (by pinging 192.168.1.1) to determine if you are connected to the internet and, if not, whether your router connection is working. 

I developed this script when my comcast internet would unexpectantly and intermittently go out. Comcast's customer service was not able to identify  historical intermittent outages and would tell me everything was working properly. Ideally, the ISP should be constantly monitoring for outages and inform customers when that occurs, but that doesn't look good so they have no incentive to be transparent.

This is a bash script, so it only works on computers that can run bash (such as Linux)

## expected output

The script is designed to only updated information when the connection information is changed. It is output as tab-separated data into the terminal, using 'echo'. This can easily be viewed in the terminal or with a text editor using a tab width of 8. Example data output:

```
time			internet	router	previous duration (seconds)
2022-07-23T10:54:56EDT	online		online	n/a
2022-07-23T12:09:33EDT	offline		online	4477
2022-07-23T12:09:36EDT	online		online	3
```

In this example, when the scripted started at 10:54 am, the internet was connected. After 4477 seconds at 12:09 pm, a ping failed to reach the external server, but communication with the router was not disrupted. This continued for 3 seconds after which connection with the external server was restored. The script was interrupted sometime after that.

## run script

1. download check_online.sh
2. change permissions to make it executable with `chmod`
3. in the terminal run `./check_online.sh > [file_name].txt`
4. cancel the script when done (on some machines this is cntl+c)
5. data about inter-connectivity is saved in the file name specified.

## limitations/troubleshooting

* This was only tested on Ubuntu 20.04 and may not run on other operating systems.
* The output does not include how long between the last change and when the connection was interrupted.
* The script runs a ping approximately every second (not exactly). You can change the wait time by editing the sleep function.
* The script pings the local server at 192.168.1.1. If your router's IP address is different, you will need to change this value in the script.

## edits, modifications or suggestions

If you have any improvements or suggestions or trouble getting it to work, feel free to reach out.

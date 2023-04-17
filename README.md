# check-internet-connection

This repository contains a bash script, `check_online.sh` which checks the connection to the internet and by your router every second to determine if you are connected to the internet or router. 

I developed this script when my comcast internet would unexpectantly and intermittently go out. Comcast's customer service was not able to identify historical intermittent outages and would tell me everything was working properly. Ideally, the ISP should be constantly monitoring for outages and inform customers when that occurs, but that is not the world we live in.

This is a bash script, so it only works on computers that can run bash (such as Linux). It was tested on Ubuntu 22.04

## expected output

The script is designed to only updated information when the connection information is changed. It is output as tab-separated data into the terminal, using 'echo'. This can easily be viewed in the terminal, with a text editor using a tab width of 8, or with a spreadsheet viewer. Example data output:

```
time			internet	router	duration (seconds)
2023-04-16T12:22:09EDT	online		online	24
2023-04-16T12:22:33EDT	offline		online	1
2023-04-16T12:22:34EDT	online		online	47
2023-04-16T12:23:21EDT	offline		online	3
2023-04-16T12:23:22EDT	online		online	
```

In this example, the script started at 12:22 pm, the internet was connected. After 24 seconds, one ping was unsuccessful to the internet. Then for 47 seconds, internet was working, followed by 3 seconds without internet. The script was interupted while internet was still operating, so the last data time was not printed.

## installation

1. download `check_online.sh`
2. change permissions to make it executable with `chmod`

# use

1. Open `check_online.sh` in a text editor.
2. Adjust the IP address of your router on `ROUTER_IP` variable on line 4 of `check_online.sh`. 
   You can view the IP address by viewing the wifi connection information. Make sure the variable
   is the same as the IPv4 IP address. The typical IP address is 192.168.1.1, though your router may differ.
3. Save this file
4. Open the terminal
5. Navigate to the folder where this script is located
6. Make sure this script has executable permissions
7. Type `./check_online.sh > [file_name].txt` in terminal and press enter. This will write
   the output to the file `[file_name].txt` and it will override any previous file with
   that name.
8. Wait however long you want for the program to collect data.
9. Open the text file you are writing to. This can be done in a text editor or spreadsheet software.
   You can open the file while the script is running, but if you do, make sure to open it in a program 
   that does not lock the file to editing by the script. 

## limitations/troubleshooting

* This was only tested on Ubuntu 22.04 and may not run on other operating systems.
* The output does not include how long between the last change and when the connection was interrupted.
* The script runs a ping approximately every second (not exactly). This software treats all pings as 
  taking equal time, so if successful and unsucessful pings differ, this would impact the resulting 
  data. If you notice any other improvements, please share it on this page.You can change the wait time 
  by editing the sleep function. 


## edits, modifications or suggestions

If you have any improvements or suggestions or trouble getting it to work, feel free to reach out.

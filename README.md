# Hospital Log Management System
this is the Management system for keeping track of patient health and water usage

## overview 

This project does this:
1. It gets real time data from patient monitorss and water usage meters
2. It saves logs nicely with timestamps
3. It also makes reports about devices and how everything changes over time

## Directory structure

hospital_data/
├── active_logs/                    # Where the current logs live
│   ├── heart_rate.log              # Looks like: TIMESTAMP DEVICE VALUE
│   ├── temperature.log
│   └── water_usage.log
├── archived_logs/                  # Old logs go here
│   ├── heart_data_archive/
│   ├── temperature_data_archive/
│   └── water_usage_data_archive/
└── reports/
└── analysis_report.txt         # Where I save the analysis results

## Python simulators

### Heart rate monitor
This heart rate monitor assumes that there are 2 heart rate monitors. Those monitors only display numbers betweern 60-120 bpm

'''bash
python3 heart_monitor.py start  #this is to begin the collection of the data
python3 heart_monitor.py stop   #this is to stop

### Temperatture sensor

'''bash
python3 temp_sensor.py start   #to start data collection
python3 temp_sensor.py stop    #to stop

### Water meter

'''bash
python3 water_meter.py start   #to start
python3 watermeter.py stop    #to stop

## Shell scripts

### archive_logs.sh
This is a script which is used to move the log files into the archive folder

'''bash
./archive_logs.sh

what it does:
1. Shows a menu where you pick 1, 2 or 3 for which log you want
2. Moves the active log file to the right archive folder
3. Gives it a name with the date and time.
4. Makes a new empty log file so the monitors can keep writing
5. Tries to tell you if something goes wrong (like file not found)

###analyze_logs.sh
This is a  script that is used to look at the logs and make a report

'''bash
./analyze_logs.sh

what it does:
1. Shows you a menu to choose which log file to look at
2. Counts how many times each device appears
3. Finds the first and last time in the log
4. Works out the min, max and average value
5. Adds everything to the file reports/analysis_report.txt

## Quick start(the way the program starts)

'''bash

# 1. Start collecting data from all sensors
python3 heart_monitor.py start
python3 temp_sensor.py start
python3 water_meter.py start

# 2. Wait a little bit so some data appears
sleep 5

# 3. Look at the log file while it's growing (optional)
tail -f hospital_data/active_logs/heart_rate.log

# 4. Put one log file into the archive
./archive_logs.sh

# 5. Make an analysis of one log file
./analyze_logs.sh

# 6. See what the report says
cat hospital_data/reports/analysis_report.txt

# 7. Stop everything when you're done
python3 heart_monitor.py stop
python3 temp_sensor.py stop
python3 water_meter.py stop

## Files

File  -->   What it does
heart_monitor.py  -->   it assumes to be heart rate monitors
temp__sensor.py   -->   it assumes to be temperature sensors
water_meter.py    -->   it assumes to be water usage meters
archive_logs.py   -->   it helps to move the log files into the archive folder
analyze_logs.py   -->   it helps to look at the logs and make a report

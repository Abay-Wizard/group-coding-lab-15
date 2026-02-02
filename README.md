This is a hospital data management program.

FIRSTLY:
We begin by runing the python logs that release heart rate, temperature and water usage data.
when this data is released it is stored in the active logs file heart_rate in heart_rate.log, temperature in temperature.log and water usage in water_usage.log

SECONDLY:
We created two scripts analyze_logs.sh and archive_logs.sh

ANALYZE_LOGS.SH: This scripts takes analyzes it and maked a report that clearly demostrates the following for heart_rate data, temperature data and water usage data
When they were generated and the exact path to the file that contains the data
Total entries made and the total entries made by each device (each heart rate monitor, temperature recorder, or water meter

FINALLY: 
the last script is the archive_logs.sh
This scripts help to take all the data from the active logs file and moves it to it's designated folder with a time stamp.

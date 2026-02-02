# Coding Lab Group Project

This is our project for the Hospital Log Management System. We made some scripts to track hospital data like heart rate, temperature, and water usage.

## What is inside this folder?

Here are the files we made:

*   **heart_monitor.py**: This creates fake heart rate data.
*   **temp_sensor.py**: This creates fake temperature data.
*   **water_meter.py**: This creates fake water usage data.
*   **archive_logs.sh**: A script to move old logs to a safe place.
*   **analyze_logs.sh**: A script to read the logs and make a report.

## How the folders are organized

We put the data in a folder called `hospital_data`:

*   `active_logs`: This is where the live data goes properly.
*   `archived_logs`: This is where we examine old files.
*   `reports`: This is where the analysis text file goes.

## How to run it

Follow these steps to test our project:

1.  **Start the programs**
    Open your terminal and type these commands to start recording:
    ```bash
    python3 heart_monitor.py start
    python3 temp_sensor.py start
    python3 water_meter.py start
    ```

2.  **Wait a little bit**
    Wait a few seconds so the files have some data in them.

3.  **Archive a log**
    Run this script to move a log file:
    ```bash
    ./archive_logs.sh
    ```
    Then choose 1, 2, or 3.

4.  **Analyze the data**
    Run this script to see stats about the devices:
    ```bash
    ./analyze_logs.sh
    ```
    Then choose which log you want to check.

5.  **See the report**
    To see the results, check this file:
    `hospital_data/reports/analysis_report.txt`

6.  **Stop everything**
    When you are done, don't forget to stop the programs:
    ```bash
    python3 heart_monitor.py stop
    python3 temp_sensor.py stop
    python3 water_meter.py stop
    ```

## Notes
Make sure the scripts have permission to run! If they don't, type `chmod +x *.sh`.


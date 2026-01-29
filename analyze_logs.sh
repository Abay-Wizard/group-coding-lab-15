#!/bin/bash

# analyze_logs.sh - Intelligent log analysis script
# Analyzes selected log files and generates reports

# Directory configuration
ACTIVE_LOGS_DIR="hospital_data/active_logs"
REPORTS_DIR="hospital_data/reports"
REPORT_FILE="${REPORTS_DIR}/analysis_report.txt"

# Log file names
HEART_LOG="heart_rate.log"
TEMP_LOG="temperature.log"
WATER_LOG="water_usage.log"

# Function to display menu and get user choice
display_menu() {
    echo "Select log file to analyze:"
    echo "1) Heart Rate (heart_rate.log)"
    echo "2) Temperature (temperature.log)"
    echo "3) Water Usage (water_usage.log)"
    echo -n "Enter choice (1-3): "
}

# Function to ensure reports directory exists
ensure_reports_dir() {
    if [ ! -d "$REPORTS_DIR" ]; then
        mkdir -p "$REPORTS_DIR"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to create reports directory."
            exit 1
        fi
    fi
}

# Function to analyze a log file
analyze_log() {
    local log_file=$1
    local log_type=$2
    local source_path="${ACTIVE_LOGS_DIR}/${log_file}"
    
    # Check if log file exists
    if [ ! -f "$source_path" ]; then
        echo "Error: Log file '$source_path' does not exist."
        echo "Make sure the monitoring device is running and has generated logs."
        exit 1
    fi
    
    # Check if log file is empty
    if [ ! -s "$source_path" ]; then
        echo "Warning: Log file is empty. Nothing to analyze."
        exit 0
    fi
    
    ensure_reports_dir
    
    echo ""
    echo "Analyzing ${log_file}..."
    echo ""
    
    # Generate analysis timestamp
    analysis_time=$(date +"%Y-%m-%d %H:%M:%S")
    
    # Start building the report
    {
        echo "=============================================="
        echo "ANALYSIS REPORT - ${log_type}"
        echo "Generated: ${analysis_time}"
        echo "Log File: ${source_path}"
        echo "=============================================="
        echo ""
        
        # Count total entries
        total_entries=$(wc -l < "$source_path")
        echo "Total Entries: ${total_entries}"
        echo ""
        
        # Device occurrence count
        echo "--- Device Statistics ---"
        echo ""
        
        # Extract unique devices and count occurrences
        # Log format: TIMESTAMP DEVICE VALUE
        awk '{print $3}' "$source_path" | sort | uniq -c | sort -rn | while read count device; do
            echo "Device: ${device}"
            echo "  Total Count: ${count}"
            
            # Get first entry timestamp for this device
            first_timestamp=$(grep " ${device} " "$source_path" | head -n 1 | awk '{print $1, $2}')
            echo "  First Entry: ${first_timestamp}"
            
            # Get last entry timestamp for this device
            last_timestamp=$(grep " ${device} " "$source_path" | tail -n 1 | awk '{print $1, $2}')
            echo "  Last Entry: ${last_timestamp}"
            echo ""
        done
        
        echo "--- Value Statistics ---"
        echo ""
        
        # Calculate min, max, and average values per device
        awk '{
            device = $3
            value = $4
            count[device]++
            sum[device] += value
            if (min[device] == "" || value < min[device]) min[device] = value
            if (max[device] == "" || value > max[device]) max[device] = value
        }
        END {
            for (d in count) {
                printf "Device: %s\n", d
                printf "  Min Value: %.2f\n", min[d]
                printf "  Max Value: %.2f\n", max[d]
                printf "  Avg Value: %.2f\n", sum[d]/count[d]
                print ""
            }
        }' "$source_path"
        
        echo "=============================================="
        echo ""
        
    } >> "$REPORT_FILE"
    
    echo "Analysis complete!"
    echo "Results appended to: ${REPORT_FILE}"
    echo ""
    
    # Also display summary to console
    echo "--- Quick Summary ---"
    echo "Total Entries: ${total_entries}"
    echo ""
    echo "Device Counts:"
    awk '{print $3}' "$source_path" | sort | uniq -c | sort -rn
}

# Main script execution
display_menu
read choice

case $choice in
    1)
        analyze_log "$HEART_LOG" "Heart Rate Monitor"
        ;;
    2)
        analyze_log "$TEMP_LOG" "Temperature Sensor"
        ;;
    3)
        analyze_log "$WATER_LOG" "Water Usage Meter"
        ;;
    *)
        echo "Error: Invalid choice. Please enter 1, 2, or 3."
        exit 1
        ;;
esac

exit 0



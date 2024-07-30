#!/bin/bash

# Log file path
LOG_FILE="/var/log/auth.log"

# Output report file
REPORT_FILE="/path/to/loginreport.txt"

# Search pattern for failed login attempts
FAILED_LOGIN_PATTERN="Failed password"

# Function to analyze login log file
analyze_login_log() {
    local log_file="$1"
    local report_file="$2"
    local failed_login_count=$(grep -c "$FAILED_LOGIN_PATTERN" "$log_file")

    # Generate report
    echo "Login Log Analysis Report" >> "$report_file"
    echo "--------------------------" >> "$report_file"
    echo "Date: $(date)" >> "$report_file"
    echo "Failed Login Attempts: $failed_login_count" >> "$report_file"
}

# Analyze login log file
analyze_login_log "$LOG_FILE" "$REPORT_FILE"

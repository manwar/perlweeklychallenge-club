#!/usr/bin/env bash
# Script to identify and report missing Perl solutions for Perl Weekly Challenges.
# Produces a report of challenge numbers missing Perl directories under lubos-kolouch.
# Usage: ./missing_perl_tasks.sh

BASE_DIR="/home/lubos/sw/scripts/perlweeklychallenge"
LOG_FILE="/tmp/missing_perl_tasks_$(date +%Y%m%d_%H%M%S).log"

echo "Scanning for missing Perl challenge directories..." > "$LOG_FILE"
echo "Generated on $(date)" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

missing_entries=()
for dir in "$BASE_DIR"/challenge-*/ ; do
    # Extract challenge number
    if [[ $(basename "$dir") =~ challenge-([0-9]+) ]]; then
        num="${BASH_REMATCH[1]}"
        # Check if lubos-kolouch/perl exists
        if [[ ! -d "$dir/lubos-kolouch/perl" ]]; then
            missing_entries+=("$num")
            echo "challenge-$num: missing Perl directory" >> "$LOG_FILE"
        fi
    fi
done

# Count total missing
count=${#missing_entries[@]}
echo "" >> "$LOG_FILE"
echo "Total challenges missing Perl solutions: $count" >> "$LOG_FILE"

# Print summary to stdout for quick view
echo "Missing Perl challenge directories:"
printf '%s\n' "${missing_entries[@]}" | nl -w2 -s': '
echo ""
echo "Detailed log written to $LOG_FILE"

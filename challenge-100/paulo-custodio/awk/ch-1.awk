#!/usr/bin/gawk

# Challenge 100
#
# TASK #1 > Fun Time
# Submitted by: Mohammad S Anwar
# You are given a time (12 hour / 24 hour).
#
# Write a script to convert the given time from 12 hour format to 24 hour format
# and vice versa.
#
# Ideally we expect a one-liner.
#
# Example 1:
# Input: 05:15 pm or 05:15pm
# Output: 17:15
# Example 2:
# Input: 19:15
# Output: 07:15 pm or 07:15pm

function convert_time(text,    hour, arr, pm) {
    text = tolower(text)

    # get hour
    match(text, /^([0-9]+)/, arr)
    hour = arr[1]
    if (text ~ /am|pm/) {
        # 12->24
        if (text ~ /pm/) {
            if (hour < 12) hour += 12;
        }
        else { /am/
            if (hour == 12) hour = 0;
        }
        gsub(/^[0-9]+/, "", text);
        gsub(/ *(am|pm)/, "", text);
        printf("%02d", hour); print text;
    }
    else {
        # 24->12
        pm = 0;
        if (hour == 0)         hour = 12;
        else if (hour == 12)   pm = 1;
        else if (hour > 12)  { hour -= 12; pm = 1; }
        gsub(/^[0-9]+/, "", text);
        printf("%02d%s", hour, text);
        if (pm)
            print "pm";
        else
            print "am";
    }
}

BEGIN {
    convert_time(ARGV[1]);
    exit 0;
}

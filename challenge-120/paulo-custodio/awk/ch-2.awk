#!/usr/bin/env gawk

# Challenge 120
#
# TASK #2 › Clock Angle
# Submitted by: Mohammad S Anwar
# You are given time $T in the format hh:mm.
#
# Write a script to find the smaller angle formed by the hands of an analog
# clock at a given time.
#
# HINT: A analog clock is divided up into 12 sectors. One sector represents 30
# degree (360/12 = 30).
#
# Example
# Input: $T = '03:10'
# Output: 35 degree
#
# The distance between the 2 and the 3 on the clock is 30 degree.
# For the 10 minutes i.e. 1/6 of an hour that have passed.
# The hour hand has also moved 1/6 of the distance between the 3 and the 4,
# which adds 5 degree (1/6 of 30).
# The total measure of the angle is 35 degree.
#
# Input: $T = '04:00'
# Output: 120 degree

function abs(v) {return v < 0 ? -v : v}

function clock_angle(hh, mm,  hh_angle, mm_angle, angle) {
    mm_angle = mm/60*360
    hh_angle = (hh % 12)/12*360 + mm_angle/360*1/12*360
    angle = abs(hh_angle - mm_angle)
    if (angle > 180) { angle = 360 - angle }
    return angle
}

BEGIN {
    split(ARGV[1], a, ":")
    angle = clock_angle(a[1], a[2])
    print angle
    exit
}

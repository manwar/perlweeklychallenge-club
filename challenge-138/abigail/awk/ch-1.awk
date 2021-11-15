#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

BEGIN {
    split ("261 260 260 261 261 261 261 262 261 260 261 262 262 262", \
            lookup, " ")
    SUNDAY    = 0
    MONDAY    = 1
    TUESDAY   = 2
    WEDNESDAY = 3
    THURSDAY  = 4
    FRIDAY    = 5
    SATURDAY  = 6
}

function doomsday (year, anchor, x, y) {
    x        = int (year / 100) % 4
    anchor   = x == 0 ? TUESDAY \
             : x == 1 ? SUNDAY  \
             : x == 2 ? FRIDAY  \
             :          WEDNESDAY
    y        = year % 100;
    return ((int (y / 12) + (y % 12) + int ((y % 12) / 4)) + anchor) % 7
}

function is_leap (year) {
    return (year % 400 == 0) || (year % 4 == 0) && (year % 100 != 0) ? 1 : 0
}

{
    print (lookup [1 + 7 * is_leap($1) + doomsday($1)])
}

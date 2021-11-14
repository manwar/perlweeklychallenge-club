#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

lookup = [
    [261, 261, 260, 260, 261, 261, 261],
    [262, 262, 261, 260, 261, 262, 262],
]

$sunday    = 0
$monday    = 1
$tuesday   = 2
$wednesday = 3
$thursday  = 4
$friday    = 5
$saturday  = 6

def doomsday (year)
    anchor = [$tuesday, $sunday, $friday, $wednesday][(year / 100) % 4]
    y      = year % 100
    return (((y / 12) + (y % 12) + ((y % 12) / 4)) + anchor) % 7
end

def is_leap (year)
    if (year % 400 == 0) || (year % 4 == 0) && (year % 100 != 0) then
        return 1
    end
    return 0
end

ARGF . each_line do
    | year |
    year = year . to_i
    puts (lookup [is_leap year] [doomsday year])
end

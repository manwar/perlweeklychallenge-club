#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

diff_per_minute =  11
min_per_hour    =  60
full_circle     = 720

ARGF . each_line do
    |time|
    hours, minutes = time . split (/:/)
    angle = (diff_per_minute * (hours . to_i * min_per_hour + minutes . to_i))\
                                             % full_circle
    angle = full_circle - angle if 2 * angle >= full_circle

    print (angle / 2)
    print (".5") if angle % 2 == 1
    print ("\n")
end

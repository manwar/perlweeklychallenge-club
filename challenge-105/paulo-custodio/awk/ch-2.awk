#!/usr/bin/gawk

# Challenge 105
#
# TASK #2 › The Name Game
# Submitted by: Mohammad S Anwar
# You are given a $name.
#
# Write a script to display the lyrics to the Shirley Ellis song The Name Game.
# Please checkout the wiki page for more information.
#
# Example
# Input: $name = "Katie"
# Output:
#
#     Katie, Katie, bo-batie,
#     Bonana-fanna fo-fatie
#     Fee fi mo-matie
#     Katie!

use strict;
use warnings;
use 5.030;

BEGIN {
    name = ARGV[1]
    end = tolower(name)
    sub(/^[bcdfghjklmnpqrstvwxyz]/, "", end)
    if (match(name, /^B/))
        bb = ""
    else
        bb = "b"
    if (match(name, /^F/))
        ff = ""
    else
        ff = "f"
    if (match(name, /^M/))
        mm = ""
    else
        mm = "m"

    print name ", " name ", bo-" bb end ","
    print "Bonana-fanna fo-" ff end
    print "Fee fi mo-" mm end
    print name "!"

    exit 0;
}

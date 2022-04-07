#!/usr/bin/env perl

# Challenge 042
#
# TASK #2
# Balanced Brackets
# Write a script to generate a string with random number of ( and ) brackets.
# Then make the script validate the string if it has balanced brackets.
#
# For example:
#
# () - OK
# (()) - OK
# )( - NOT OK
# ())() - NOT OK

use Modern::Perl;

while (<>) {
    chomp;
    print "$_ - ";
    1 while s/\(\)//;
    say $_ eq '' ? "OK" : "NOT OK";
}

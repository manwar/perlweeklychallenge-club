#!/usr/bin/perl6
use v6;

# 20.1
# Write a script to accept a string from command line and split it on change of character. For example, if the string is “ABBCDEEF”, then it should split like “A”, “BB”, “C”, “D”, “EE”, “F”.

sub MAIN ($string where .chars >0) {
    .Str.say for $string ~~ m:g / ((.) $0*) /
}

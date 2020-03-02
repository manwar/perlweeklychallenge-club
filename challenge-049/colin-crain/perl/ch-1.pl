#! /opt/local/bin/perl
#
#       49_1_smallest_multiple.pl
#
#         PWC 49 - TASK #1
#         Smallest Multiple
#             Write a script to accept a positive number as command line argument and
#             print the smallest multiple of the given number consists of digits 0 and
#             1.
#
#         For example:
#
#         For given number 55, the smallest multiple is 110 consisting of digits 0 and 1.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $input = shift @ARGV;

my $multiplier = 1;
my $value;

while ( $multiplier++ ) {
    $value = $input * $multiplier;
    next if $value =~ /[23456789]/;
    last;
}

printf "number: %5d       smallest multiple: %-15d\n", $input, $value;

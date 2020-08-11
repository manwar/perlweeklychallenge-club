#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-10-01
# Week: 028

# Task #2
# Write a script to display Digital Clock. Feel free to be as creative
# as you can when displaying digits. We expect bare minimum something
# like “14:10:11”.

# Usage: % perl ch-2.pl
# ouput:     _   _  _   _  _
#          |  |. _| _|. _||_|
#          |  |.|_ |_ . _| _|

use strict;
use warnings;
use feature qw/ say /;
use DateTime;

my $dt = DateTime->now;
my $hour   = $dt->hour;
my $minute = $dt->minute;
my $second = $dt->second;
my $digital = sprintf( "%02d:%02d:%02d", $hour, $minute, $second );
my @colon = ( " ", ".", "." );
my @digits;
$digits[0] = [ " _ ", "| |", "|_|" ];
$digits[1] = [ "   ", "  |", "  |" ];
$digits[2] = [ " _ ", " _|", "|_ " ];
$digits[3] = [ " _ ", " _|", " _|" ];
$digits[4] = [ "   ", "|_|", "  |" ];
$digits[5] = [ " _ ", "|_ ", " _|" ];
$digits[6] = [ " _ ", "|_ ", "|_|" ];
$digits[7] = [ " _ ", "  |", "  |" ];
$digits[8] = [ " _ ", "|_|", "|_|" ];
$digits[9] = [ " _ ", "|_|", " _|" ];

print_digital($digital);

sub print_digital {
    my $digital_string = shift;
    my @digit_to_print = split //, $digital_string;
    for ( my $i = 0; $i < 3; $i++ ) {
        for my $d (@digit_to_print) {
            if ( $d eq ":" ) {
                print $colon[$i];
            }
            else {
                print $digits[$d][$i];
            }
        }
        print "\n";
    }
}

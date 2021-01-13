#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
use POSIX;

my $year = 2019;
my @days = (31, 28 + is_leap($year), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

for my $month ( 0 .. 11 ) {
    my $count = grep {
        strftime( "%w", 0, 0, 0, $_+6, $month, $year - 1900 ) < 5
    } 1 .. $days[$month];
    say strftime( "%b", 0, 0, 0, 1, $month, $year - 1900 ) . ": $count days";
}

sub is_leap {
    strftime("%w", 0, 0, 0, 29 , 1, $_[0] - 1900 ) ne
    strftime("%w", 0, 0, 0,  1 , 2, $_[0] - 1900 );
}
=begin
perl .\ch-1.pl       
Jan: 23 days
Feb: 20 days
Mar: 21 days
Apr: 22 days
May: 23 days
Jun: 20 days
Jul: 23 days
Aug: 22 days
Sep: 21 days
Oct: 23 days
Nov: 21 days
Dec: 22 days
=cut
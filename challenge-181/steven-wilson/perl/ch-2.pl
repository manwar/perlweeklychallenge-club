#!/usr/bin/env perl
# Week 181 Task 2: Hot Day
# You are given file with daily temperature record in random order.
# Write a script to find out days hotter than previous day.
# Example
# Input File: (temperature.txt)

# 2022-08-01, 20
# 2022-08-09, 10
# 2022-08-03, 19
# 2022-08-06, 24
# 2022-08-05, 22
# 2022-08-10, 28
# 2022-08-07, 20
# 2022-08-04, 18
# 2022-08-08, 21
# 2022-08-02, 25

# Output:
# 2022-08-02
# 2022-08-05
# 2022-08-06
# 2022-08-08
# 2022-08-10

use strict;
use warnings;
use feature qw/ say /;

my $filename = "temperature.txt";
my %data;
my @dates_sorted;
my @dates_hotter;

open( my $fh, "<", $filename )
    or die "Can't open < input.txt: $!";

while ( my $line = <$fh> ) {
    $line =~ m/(\d+-\d+-\d+), (\d+)/g;
    $data{$1} = $2;
}

@dates_sorted = sort keys %data;
my $num_of_dates = scalar @dates_sorted;

for ( my $i = 1; $i < $num_of_dates; $i++ ) {
    if ( $data{ $dates_sorted[$i] } > $data{ $dates_sorted[ $i - 1 ] } ) {
        push @dates_hotter, $dates_sorted[$i];
    }
}

foreach (@dates_hotter) {
    say $_;
}


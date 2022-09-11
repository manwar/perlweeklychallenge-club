#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

# reading a file isn't the interesting part.

my @data;
while (<DATA>) {
    chomp;
    next unless /\d/;
    push @data, $_;
}

my $prev = 1000;
for my $day ( sort @data ) {
    my ( $date, $temp ) = split /\,\ /, $day;
    if ( $temp > $prev ) {
        say $date;
    }
    $prev = $temp;
}

__DATA__
2022-08-01, 20
2022-08-09, 10
2022-08-03, 19
2022-08-06, 24
2022-08-05, 22
2022-08-10, 28
2022-08-07, 20
2022-08-04, 18
2022-08-08, 21
2022-08-02, 25

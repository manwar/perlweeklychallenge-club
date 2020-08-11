#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use Getopt::Std;

my %opts;
getopt('n:', \%opts);

$opts{'n'} //= 1;

my @series = @ARGV;
for (0 .. $opts{'n'} - 1) {
    @series = map { $series[$_] - $series[$_ - 1] } (1 .. $#series);
}

say join q{, }, @series;
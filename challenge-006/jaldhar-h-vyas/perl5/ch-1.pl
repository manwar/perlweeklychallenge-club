#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

sub usage {
    print <<"-USAGE-";
Usage:
  $PROGRAM_NAME <numberlist>

    <numberlist>    comma-separated list of numbers to display compacted.
-USAGE-

    exit(1);
}

if (scalar @ARGV < 1) {
    usage();
}

my @numbers = sort { $a <=> $b } split /,/, $ARGV[0];
my $lastelem = scalar @numbers - 1;
my @ranges;
my $start;
my $current = 0;

while ($current <= $lastelem) {
    $start = $current;

    while ($current < $lastelem &&
    $numbers[$current] + 1 == $numbers[$current + 1]) {
        $current++;
    }

    if ($numbers[$current] == $numbers[$start]) {
        push @ranges, $numbers[$start];
    } elsif ($numbers[$current] == $numbers[$start] + 1) {
        push @ranges, $numbers[$start], $numbers[$current];
    } else {
        push @ranges, "$numbers[$start]-$numbers[$current]";
    }

    $current++;
}

say join q{,}, @ranges;

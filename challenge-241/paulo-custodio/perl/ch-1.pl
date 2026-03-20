#!/usr/bin/env perl

# Perl Weekly Challenge 241 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-241/

use Modern::Perl;

# parse args
sub usage { return "Usage: $0 -nums n n n ... -diff n\n"; }

my(@nums, $diff);
while (@ARGV) {
    if ($ARGV[0] eq "-nums") {
        shift;
        while (@ARGV && $ARGV[0] !~ /^-/) {
            push @nums, shift;
        }
    }
    elsif ($ARGV[0] eq "-diff") {
        shift;
        $diff = shift;
    }
    else {
        die usage();
    }
}
if (!@nums || !$diff) { die usage(); }

# compute
my $count = 0;
for my $i (0 .. $#nums-2) {
    for my $j ($i+1 .. $#nums-1) {
        for my $k ($j+1 .. $#nums) {
            $count++ if ($nums[$j] - $nums[$i] == $diff &&
                         $nums[$k] - $nums[$j] == $diff);
        }
    }
}

# output
say $count;

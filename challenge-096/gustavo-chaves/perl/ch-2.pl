#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-096/
# TASK #2 › Edit Distance

use 5.030;
use warnings;

my $S1 = shift;
my $S2 = shift;

my @S1 = split '', $S1;
my @S2 = split '', $S2;

sub distance {
    my ($i, $j) = @_;

    if ($i < 0 && $j < 0) {
        return;
    } elsif ($j < 0) {
        return map {"delete '$S1[$_]'"} 0 .. $i;
    } elsif ($i < 0) {
        return map {"delete '$S2[$_]'"} 0 .. $j;
    } elsif ($S1[$i] eq $S2[$j]) {
        return distance($i-1, $j-1);
    } else {
        my @del = (distance($i-1, $j), "delete '$S1[$i]' from $i");
        my @ins = (distance($i, $j-1), "insert '$S2[$j]' at $j");
        my @sub = (distance($i-1, $j-1), "replace '$S1[$i]' at $i with '$S2[$j]'");
        return @{(sort {scalar(@$a) <=> scalar(@$b)} \@del, \@ins, \@sub)[0]};
    }
}

my @ops = distance($#S1, $#S2);

say "Operation $_: $ops[$_-1]" for 1 .. @ops;

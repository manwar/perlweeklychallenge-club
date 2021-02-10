#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-099/
# TASK #2 › Unique Subsequence

use 5.030;
use warnings;

my ($S, $T) = @ARGV;

sub matches {
    my ($s, $t) = @_;

    return 1 if $t == length($T);

    my $matches = 0;

    my $c = substr($T, $t, 1);
    foreach my $i ($s .. length($S)-1) {
        if ($c eq substr($S, $i, 1)) {
            $matches += matches($i+1, $t+1);
        }
    }

    return $matches;
}

say matches(0, 0);

#!/usr/bin/env perl

# Perl Weekly Challenge 217 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-217/

use Modern::Perl;

sub by_largest {
    my($a, $b) = @_;

    if (substr($a,0,1) ne substr($b,0,1)) {
        return $b cmp $a;
    }
    else {
        return length($a) <=> length($b);
    }
}

say join '', sort {by_largest($a,$b)} @ARGV;

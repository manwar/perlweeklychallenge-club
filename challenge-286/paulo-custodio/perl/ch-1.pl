#!/usr/bin/env perl

# Challenge - word for the test.pl test case

# Perl Weekly Challenge 286 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-286/

# Challenge 286

use Modern::Perl;
use Path::Tiny;
use List::Util 'shuffle';

if (@ARGV) {
    my $n = shift // 0;
    say((split " ", path($0)->slurp)[$n]);
}
else {
    say((shuffle(split " ", path($0)->slurp))[0]);
}

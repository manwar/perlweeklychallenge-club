#!/usr/bin/env perl

# Perl Weekly Challenge 289 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-289/

use Modern::Perl;
use List::Util 'shuffle';

@ARGV and srand(shift//0);

while (<>) {
    s/(\w)(\w*)(\w)/$1 . join('', shuffle(split '', $2)) . $3/ge;
    print;
}

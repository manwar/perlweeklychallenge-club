#!/usr/bin/env perl

# Perl Weekly Challenge 229 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-229/

use Modern::Perl;
use List::Util 'uniq';

my @arrays = map {[uniq split ' ', $_]} split /,/, "@ARGV";
my %count;
for (@arrays) {
    for (@$_) {
        $count{$_}++;
    }
}
say "(", join(', ',
        map {$_->[0]}
        grep {$_->[1] >= 2}
        map {[$_, $count{$_}]}
        sort {$a <=> $b} keys %count), ")";

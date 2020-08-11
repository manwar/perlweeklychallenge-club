#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

# Write a script to print all possible series of 3 positive numbers,
# where in each series at least one of the number is even and sum of
# the three numbers is always 12. For example, 3,4,5.

# First note: three odd integers cannot equal an even number, so the
# "at least one must be even" is a red herring. One or three have to be
# even.

# Second note: if we allow duplication, 4 + 4 + 4 equals 12, and there's
# no rule in the books that says Dogs can't play Perl Weekly Ch...
# I mean, that we cannot have duplicate positive integers.

my %done ;

for my $m ( 1 .. 10 ) {
    for my $n ( 1 .. 10 ) {
        for my $o ( 1 .. 10 ) {
            my $i = join ' ' , sort $m,$n,$o;
            next if $done{$i}++;;
            my $p = $m + $n + $o;
            next unless $p == 12;
            say qq{    $m + $n + $o = $p};
        }
    }
}

# but the trick to avoid duplicates is for $n to start with $m+1
# and $o to start with $n+1.

__DATA__

    1 + 1 + 10 = 12
    1 + 2 + 9 = 12
    1 + 3 + 8 = 12
    1 + 4 + 7 = 12
    1 + 5 + 6 = 12
    2 + 2 + 8 = 12
    2 + 3 + 7 = 12
    2 + 4 + 6 = 12
    2 + 5 + 5 = 12
    3 + 3 + 6 = 12
    3 + 4 + 5 = 12
    4 + 4 + 4 = 12

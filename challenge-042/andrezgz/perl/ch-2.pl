#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-042/
# Task #2
# Balanced Brackets
# Write a script to generate a string with random number of ( and ) brackets.
# Then make the script validate the string if it has balanced brackets.
#
# For example:
#
# () - OK
# (()) - OK
# )( - NOT OK
# ())() - NOT OK


use strict;
use warnings;

my $brackets = int rand(10) + 1;

my $str = '';
$str .= rand() < 0.5 ? '(' : ')' for ( 1 .. $brackets );

my $open_count = 0;
foreach my $b ( split //, $brackets ) {
    last if $open_count < 0;
    $b eq '(' ? $open_count++ : $open_count--;
}

print $str , ' - ', $open_count ? 'NOT OK' : 'OK';

#!/usr/bin/env perl

# The Weekly Challenge 249 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-249/
#
# Task 2 - DI String Match
#

use strict;
use warnings;
use v5.28;
use Algorithm::Combinatorics qw(permutations);
use Data::Dump qw(dump);

my @examples = (
    'IDID',
    'III',
    'DDI',
);

sub di_string_match {
    my @s = split(//, shift);
    my $length =scalar @s;
    my @data = (0 .. $length);

    my $iter = permutations(\@data);
    while (my $perm = $iter->next) {
        my $ok = 1;

        for (my $i = 0; $i < $length; $i++) {
            if ((($s[$i] eq 'I') and (@$perm[$i] >= @$perm[$i + 1])) or
                (($s[$i] eq 'D') and (@$perm[$i] <= @$perm[$i + 1]))) {
                $ok = 0;
                last
            }
        }

        return $perm if ($ok)
    }
     
    return '';
}

for my $elements (@examples) {
    my $dsm = di_string_match $elements;

    say 'Input : @str = ', $elements;
    say 'Output : ', dump(@$dsm);
    say ' ';
}

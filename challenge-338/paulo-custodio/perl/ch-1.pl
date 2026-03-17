#!/usr/bin/env perl

# Perl Weekly Challenge 338 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-338/

use Modern::Perl;
use List::Util qw(max sum);

my @m = parse_input();
say max map {sum @$_} @m;

sub parse_input {
    my @m;
    while (<>) {
        my @r = split ' ', $_;
        push @m, \@r;
    }
    return @m;
}

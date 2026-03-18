#!/usr/bin/env perl

# Perl Weekly Challenge 238 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-238/

use Modern::Perl;

my @ints = @ARGV;
say "(", join(", ",
    map {$_->[0]}
    sort {$a->[1] == $b->[1] ? $a->[0] <=> $b->[0] : $a->[1] <=> $b->[1]}
    map {[$_, count_steps($_)]} @ints), ")";

sub count_steps {
    my($n) = @_;
    my $steps = 0;
    while ($n > 9) {
        my @digits = split //, $n;
        my $expr = join "*", @digits;
        $n = eval($expr); die $@ if $@;
        $steps++;
    }
    return $steps;
}

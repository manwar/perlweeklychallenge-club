#!/usr/bin/env perl

# Perl Weekly Challenge 236 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-236/

use Modern::Perl;

my @ints = @ARGV;
my @visited = (0) x @ints;
my $loops = 0;

while ((my $start = next_unvisited(@visited)) != -1) {
    do_loop($start, \@ints, \@visited);
    $loops++;
}
say $loops;

sub next_unvisited {
    my(@visited) = @_;
    for my $i (0 .. $#visited) {
        return $i if !$visited[$i];
    }
    return -1;
}

sub do_loop {
    my($start, $ints, $visited) = @_;
    my $i = $start;
    $visited->[$i] = 1;
    while ($ints->[$i] != $start) {
        $i = $ints->[$i];
        $visited->[$i] = 1;
    }
}

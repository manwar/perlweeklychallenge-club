#!/usr/bin/env perl

# Perl Weekly Challenge 222 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-222/

use Modern::Perl;

my @ints = @ARGV;
say last_member(@ints);

sub last_member {
    my(@ints) = @_;
    for (;;) {
        return 0 if @ints==0;
        return $ints[0] if @ints==1;
        @ints = sort {$a <=> $b} @ints;
        my $y = pop @ints;
        my $x = pop @ints;
        if ($x != $y) {
            push @ints, $y-$x;
        }
    }
}

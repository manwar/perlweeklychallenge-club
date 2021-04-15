#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply( gen_bell_numbers(10),
           [ 1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147] );

done_testing;

sub gen_bell_numbers {
    my ($count) = @_;

    my $bt = gen_bell_triangle($count);
    my $bn = [];
    push @$bn, $bt->[$_][0] for 0 .. --$count;

    return $bn;
}

sub gen_bell_triangle {
    my ($rows) = @_;

    my $bt = [ [1] ];
    foreach my $r (1 .. --$rows) {
        foreach my $c (0 .. $r) {
            ($c == 0) and ($bt->[$r][$c] = $bt->[$r-1][-1]) and next;
            $bt->[$r][$c] = $bt->[$r-1][$c-1] + $bt->[$r][$c-1];
        }
    }

    return $bt;
}

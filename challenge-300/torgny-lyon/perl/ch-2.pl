#!/usr/bin/perl

use v5.40;

use Test::More tests => 2;
use List::Util qw(first max);

sub get_longest {
    return max map { scalar @$_ } build_sets(@_);
}

sub build_sets {
    my @sets;
    foreach (0..$#_) {
        my @a;
        while (1) {
            my $e = get_element([@_], $_, scalar @a);
            last if defined first { $e == $_ } @a;
            push @a, $e;
        }
        push @sets, [@a];
    }
    return @sets;
}

sub get_element {
    my ($a, $i, $depth) = @_;
    return $depth ? get_element($a, $a->[$i], $depth - 1) : $a->[$i];
}

is(get_longest(5, 4, 0, 3, 1, 6, 2), 4);
is(get_longest(0, 1, 2),             1);

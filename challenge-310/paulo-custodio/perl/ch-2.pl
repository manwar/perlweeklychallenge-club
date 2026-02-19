#!/bin/env perl

use Modern::Perl;

my @list = @ARGV;
my @sorted = sort_odd_even(@list);
say "(", join(", ", @sorted), ")";

sub sort_odd_even {
    my(@list) = @_;

    my @even, my @odd;
    while (@list) {
        my($a, $b) = splice(@list, 0, 2);
        push @even, $a if defined $a;
        push @odd, $b if defined $b;
    }

    @even = sort {$a <=> $b} @even;
    @odd = sort {$b <=> $a} @odd;

    my @zip;
    while (@even || @odd) {
        push @zip, shift(@even), shift(@odd);
    }
    @zip = grep {defined} @zip;

    return @zip;
}

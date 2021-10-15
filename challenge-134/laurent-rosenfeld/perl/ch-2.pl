#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub multiplication_table {
    my ($m, $n) = @_;
    my %distinct;
    say "x |", join " ", map {sprintf "%3d", $_} 1..$n;
    for my $i (1..$m) {
        my @res = map $i * $_, 1..$n;
        $distinct{$_} = 1 for @res;
        say "$i |", join " ", map {sprintf "%3d", $_} @res;
    }
    say "Distinct terms: ", join " ", sort keys %distinct;
    say "Count: ", scalar keys %distinct;
}
multiplication_table(7, 5);

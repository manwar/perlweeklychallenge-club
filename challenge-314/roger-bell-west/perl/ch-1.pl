#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(equalstrings(['abc', 'abb', 'ab']), 2, 'example 1');
is(equalstrings(['ayz', 'cyz', 'xyz']), -1, 'example 2');
is(equalstrings(['yza', 'yzb', 'yzc']), 3, 'example 3');

use List::Util qw(sum min);

sub equalstrings($a) {
    my %ax = map {$_ => 1} @{$a};
    my @ca;
    foreach my $x (keys %ax) {
        push @ca, [split '', $x];
    }
    my $mmlen = min(map{scalar @{$_}} @ca);
    my $si = 0;
    foreach my $i (0 .. $mmlen-1) {
        $si = $i;
        foreach my $s (1 .. scalar @ca - 1) {
            if ($ca[0][$i] ne $ca[$s][$i]) {
                if ($i == 0) {
                    return -1;
                }
                $si -= 1;
                last;
            }
        }
    }
    sum(map{length($_)} @{$a}) - scalar @{$a} * ($si + 1);
}

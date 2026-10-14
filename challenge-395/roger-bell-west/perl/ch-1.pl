#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(complexnumber('1+1i', '1+1i'), '0+2i', 'example 1');
is(complexnumber('1+(-1)i', '1+(-1)i'), '0+(-2)i', 'example 2');
is(complexnumber('0+3i', '0+4i'), '-12+0i', 'example 3');
is(complexnumber('3+4i', '3+(-4)i'), '25+0i', 'example 4');
is(complexnumber('50+-20i', '-10+30i'), '100+1700i', 'example 5');

sub parsecomplex($a) {
    if ($a =~ /^\(?([-0-9]+)\)?\+\(?([-0-9]+)\)?i$/) {
        [$1 + 0, $2 + 0];
    } else {
        [0, 0];
    }
}

sub complexnumber($aa, $bb) {
    my ($a, $b) = @{parsecomplex($aa)};
    my ($c, $d) = @{parsecomplex($bb)};
    my $ca = $a *$c - $b * $d;
    my $cb = $a *$d + $b * $c;
    if ($cb < 0) {
        $cb = "($cb)";
    }
    "$ca+${cb}i";
}

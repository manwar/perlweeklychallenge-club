#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Math::BigRat;

sub mediant ($p, $q, $depth) {
    my $m = Math::BigRat->new($p->numerator + $q->numerator)
          / ($p->denominator + $q->denominator);
    return $m->denominator <= $depth ? $m : undef
}

sub farey_sequence ($n) {
    my @farey = map 'Math::BigRat'->new($_), '0/1', '1/1';
    for my $depth (2 .. $n) {
        for (my $i = 0; $i < $#farey; ++$i) {
            if (my $m = mediant($farey[$i], $farey[1 + $i], $depth)) {
                splice @farey, ++$i, 0, $m;
            }
        }
    }
    @farey[0, -1] = ('0/1', '1/1');
    return \@farey
}

use Test::More tests => 3;

is_deeply farey_sequence(5),
    [qw[ 0/1 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 1/1 ]],
    'Example 1';

is_deeply farey_sequence(7),
    [qw[ 0/1 1/7 1/6 1/5 1/4 2/7 1/3 2/5 3/7
         1/2 4/7 3/5 2/3 5/7 3/4 4/5 5/6 6/7 1/1 ]],
    'Example 2';

is_deeply farey_sequence(4),
    [qw[ 0/1 1/4 1/3 1/2 2/3 3/4 1/1 ]],
    'Example 3';

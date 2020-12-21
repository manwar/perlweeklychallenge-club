#!/usr/bin/perl
use warnings;
use strict;

sub are_isomorphic {
    my ($s, $t) = @_;
    return 0 unless length($s) == length($t);

    my %tr;
    for my $i (0 .. length($s) - 1) {
        my $si = substr $s, $i, 1;
        my $ti = substr $t, $i, 1;
        return 0 if ($tr{s2t}{$si} //= $ti) ne $ti
                 || ($tr{t2s}{$ti} //= $si) ne $si;
    }
    return 1
}

use Test::More tests => 3 + 3;

is are_isomorphic('abc', 'xyz'), 1, 'Example 1';
is are_isomorphic('abb', 'xyy'), 1, 'Example 2';
is are_isomorphic('sum', 'add'), 0, 'Example 3';

is are_isomorphic('aaa', 'bbbb'), 0, 'Different length';
is are_isomorphic('add', 'sum'), 0, 'Inverted example 3';
is are_isomorphic('aabb', '\\\\//'), 1, 'Special chars';

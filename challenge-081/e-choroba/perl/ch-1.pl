#!/usr/bin/perl
use warnings;
use strict;

sub common_base_string {
    my ($s1, $s2) = @_;
    ($s1, $s2) = ($s2, $s1) if length $s2 < length $s1;
    my @r;
    for my $d (1 .. length $s2) {
        next unless 0 == length($s2) % $d;
        my $part = substr $s2, 0, length($s2) / $d;
        unshift @r, $part
            if $s2 eq $part x $d
            && $s1 =~ /^(?:$part)+$/;
    }
    return \@r
}


use Test::More tests => 4;

is_deeply common_base_string('abcdabcd',
                             'abcdabcdabcdabcd'),
    ['abcd', 'abcdabcd'],
    'Example 1';

is_deeply common_base_string('aaa',
                             'aa'),
    ['a'],
    'Example 2';

is_deeply common_base_string('XXXX',
                             'XXXX'),
    ['X', 'XX', 'XXXX'],
    'Same strings';

is_deeply common_base_string('ABCD',
                             'EF'),
    [],
    'No common string';

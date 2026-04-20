#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

# Might be useful for larger strings:
# use Memoize qw{ memoize unmemoize };

sub scramble_string($str1, $str2) {
    # memoize('_all_scrambles');
    my $all = _all_scrambles($str1);
    # unmemoize('_all_scrambles');
    return exists $all->{$str2}
}

sub _all_scrambles($string) {
    return {$string => undef} if 1 == length $string;
    my %s;
    for my $pos (1 .. length($string) - 1) {
        my $part1 = _all_scrambles(substr $string, 0, $pos);
        my $part2 = _all_scrambles(substr $string, $pos);
        for my $k1 (keys %$part1) {
            for my $k2 (keys %$part2) {
                undef $s{ $k1 . $k2 };
                undef $s{ $k2 . $k1 };
            }
        }
    }
    return \%s
}

use Test2::V0;
plan(5 + 1);

use constant {true  => bool(1),
              false => bool(0)};

is scramble_string('abc', 'acb'), true, 'Example 1';
is scramble_string('abcd', 'cdba'), true, 'Example 2';
is scramble_string('hello', 'hiiii'), false, 'Example 3';
is scramble_string('ateer', 'eater'), true, 'Example 4';
is scramble_string('abcd', 'bdac'), false, 'Example 5';


#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub lexicographic_order(@str) {
    scalar grep {
        my $s = $_;
        my $l = length $s;

        # Skip over an initial repeated char.
        my $index = 0;
        ++$index until $index >= $l - 2
                    || substr($s, $index, 1) cmp substr($s, $index + 1, 1);

        my $first_cmp
            = $l && (substr($s, $index, 1) cmp substr($s, $index + 1, 1));

        grep {
            my $cmp = substr($s, $_, 1) cmp substr($s, $_ + 1, 1);
            $cmp && $first_cmp != $cmp
        }
        $index + 1 .. $l - 2
    } @str
}

use Test::More tests => 2 + 3;

is lexicographic_order('abc', 'bce', 'cae'), 1, 'Example 1';
is lexicographic_order('yxz', 'cba', 'mon'), 2, 'Example 2';

is lexicographic_order('abcdef', 'abcde', 'zyxw', 'aemz', 'ababa', 'xax'), 2,
    'longer strings';
is lexicographic_order("", 'a', 'ab', 'ba'), 0, 'short strings';
is lexicographic_order('aaaaab', 'abbbb'), 0, 'repeated char';

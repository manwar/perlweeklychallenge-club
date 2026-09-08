#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub order_characters($str, $k) {
    my %p = ($str => 0);
    my $smallest = $str;
    my $change = 1;
    while ($change) {
        undef $change;
        for my $s (keys %p) {
            next if $p{$s};

            $p{$s} = 1;
            $smallest = $s if $s lt $smallest;
            for my $pos (0 .. $k - 1) {
                my $copy = $s;
                $copy .= substr $copy, $pos, 1, "";
                next if exists $p{$copy};

                $p{$copy} = 0;
                $change = 1;
            }
        }
    }
    return $smallest
}

use Test::More tests => 7;

is order_characters('dbca', 1), 'adbc', 'Example 1';
is order_characters('geeks', 2), 'eegks', 'Example 2';
is order_characters('cbaed', 3), 'abcde', 'Example 3';
is order_characters('fedcba', 4), 'abcdef', 'Example 4';
is order_characters('perl', 1), 'erlp', 'Example 5';
is order_characters('oloolooo', 1), 'looloooo', 'Example 6';
is order_characters('oloooolo', 1), 'looloooo', 'Example 7';

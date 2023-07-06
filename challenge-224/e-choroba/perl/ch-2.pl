#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub additive_number($string) {
    for my $l1 (1 .. length($string) - 1) {
      LENGTH:
        for my $l2 (1 .. length($string) - $l1) {
            my $first  = substr $string, 0, $l1;
            my $second = substr $string, $l1, $l2;
            my $pos    = 0;
            while (1) {
                my $plus = $first + $second;

                next LENGTH unless $pos == index $string, "$first$second$plus";

                return 1 if $pos + length "$first$second$plus" == length $string;

                $pos   += length $first;
                $first  = $second;
                $second = $plus;
            }
        }
    }
    return
}

use Test::More tests => 3;

ok additive_number('112358'), 'Example 1';
ok ! additive_number('12345'), 'Example 2';
ok additive_number('199100199'), 'Example 3';

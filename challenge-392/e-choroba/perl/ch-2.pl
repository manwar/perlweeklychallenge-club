#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ any };

sub words_length_product(@words) {
    my $prod = 0;
    for my $i (1 .. $#words) {
        my $word1 = $words[$i];
        for my $j (0 .. $i - 1) {
            my $word2 = $words[$j];
            my %char;
            $char{$_} = 1 for split //, $word1;
            next if any { $_ } delete @char{ split //, $word2 };

            my $p = length($word1) * length($word2);
            $prod = $p if $p > $prod;
        }
    }
    return $prod
}

use Test::More tests => 5;

is words_length_product(qw( a ab abc d de def )), 9, 'Example 1';
is words_length_product(qw( a aa aaa aaaa )), 0, 'Example 2';
is words_length_product(qw( meet app code sky bold )), 16, 'Example 3';
is words_length_product(qw( a ab abc abcd efghi )), 20, 'Example 4';
is words_length_product(qw( xyz w abcdefg hij )), 21, 'Example 5';

#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub single_common_word(@arrays) {
    my %freq;
    for my $array_idx (0, 1) {
        for my $word (@{ $arrays[$array_idx] }) {
            $freq{more}{$word}{$array_idx}
                = $freq{once}{$word} && delete $freq{once}{$word}{$array_idx}
                if (! exists $freq{more}{$word}
                    || ! exists $freq{more}{$word}{$array_idx}
                ) && $freq{once}{$word}{$array_idx}++;
        }
    }
    delete @{ $freq{once} }{ keys %{ $freq{more} } };
    return scalar grep 2 == keys %{ $freq{once}{$_} }, keys %{ $freq{once} }
}

use Test::More tests => 5;

is single_common_word(['apple', 'banana', 'cherry'],
                      ['banana', 'cherry', 'date']),
    2, 'Example 1';

is single_common_word(['a', 'ab', 'abc'],
                      ['a', 'a', 'ab', 'abc']),
    2, 'Example 2';

is single_common_word(['orange', 'lemon'],
                      ['grape', 'melon']),
    0, 'Example 3';

is single_common_word(['test', 'test', 'demo'],
                      ['test', 'demo', 'demo']),
    0, 'Example 4';

is single_common_word(['Hello', 'world'],
                      ['hello', 'world']),
    1, 'Example 5';

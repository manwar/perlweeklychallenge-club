#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub odd_string (@s) {
    my %difference_array;
    for my $string (@s) {
        my @da;
        for my $pos (1 .. length($string) - 1) {
            push @da, ord(substr $string, $pos, 1)
                      - ord(substr $string, $pos - 1, 1);
        }
        push @{ $difference_array{"@da"} }, $string;
        die 'Too many different strings' if 2 < keys %difference_array;
    }
    die 'No odd string' if 1 == keys %difference_array;

    my @ones = grep 1 == @{ $difference_array{$_} }, keys %difference_array;
    die 'Too many candidates'   if 2 == @ones;
    die 'Both groups too large' if 1 != @ones;

    return $difference_array{ $ones[0] }[0]
}

use Test2::V0;
plan 6;

is odd_string('adc', 'wzy', 'abc'), 'abc', 'Example 1';
is odd_string('aaa', 'bob', 'ccc', 'ddd'), 'bob', 'Example 2';

like dies { odd_string('aaa', 'abc', 'ace') },
    qr/Too many different strings/,
    'Too many';

like dies { odd_string('aaa', 'bbb', 'ccc') },
    qr/No odd string/,
    'All same';

like dies { odd_string('aaa', 'bbb', 'abc', 'xyz') },
    qr/Both groups too large/,
    'Too large';

like dies { odd_string('aaa', 'abc') },
    qr/Too many candidates/,
    'Several ones';

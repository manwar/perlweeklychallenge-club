#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

my @cardinals = qw( one two three four five six seven eight nine );

sub four_is_magic ($n) {
    ucfirst _four_is_magic($n) . '.'
}

sub _four_is_magic ($n) {
    return 'four is magic' if 4 == $n;

    my $word = $cardinals[ $n - 1 ];
    my $length = length $word;
    return "$word is $cardinals[ $length - 1 ], " . _four_is_magic($length)
}

use Test::More tests => 3;

is four_is_magic(5),
    'Five is four, four is magic.', 'Example 1';
is four_is_magic(7),
    'Seven is five, five is four, four is magic.', 'Example 2';
is four_is_magic(6),
    'Six is three, three is five, five is four, four is magic.', 'Example 3';

#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub uncommon_words($sentence1, $sentence2) {
    my %h;
    ++$h{$_} for split / /, "$sentence1 $sentence2";
    return grep 1 == $h{$_}, keys %h
}

use Test2::V0;
plan(5);

is [uncommon_words('apple banana apple', 'banana orange')],
    bag { item $_ for qw( orange ); end() },
    'Example 1';

is [uncommon_words('cat dog', 'bird fish')],
    bag { item $_ for qw( cat dog bird fish ); end() },
    'Example 2';

is [uncommon_words('the quick brown fox', 'the quick')],
    bag { item $_ for qw( brown fox ); end() },
    'Example 3';

is [uncommon_words('hello', 'hello')], [], 'Example 4';


is [uncommon_words('blue blue red', 'red green green yellow')],
    bag { item $_ for qw( yellow ); end() },
    'Example 5';

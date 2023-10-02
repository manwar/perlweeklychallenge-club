#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub good_strings($words, $chars) {
    my $count = 0;
    my %usable;
    ++$usable{$_} for split //, $chars;
  WORD:
    for my $word (@$words) {
        my %used = %usable;
        for my $char (split //, $word) {
            next WORD unless $used{$char}--;
        }
        $count += length $word;
    }
    return $count
}

use Test::More tests => 2 + 1;

is good_strings(['cat', 'bt', 'hat', 'tree'], 'atach'), 6, 'Example 1';
is good_strings(['hello', 'world', 'challenge'], 'welldonehopper'),
    10, 'Example 2';

is good_strings(['abc', 'defg'], 'xyz'), 0, 'Zero';

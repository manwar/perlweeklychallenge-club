#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub odd_one_out(@words) {
    scalar grep {
        my $word = $_;
        grep substr($word, $_ - 2, 1) gt substr($word, $_ - 1, 1),
             2 .. length $word
    } @words
}

use Test::More tests => 3;

is odd_one_out('abc', 'xyz', 'tsu'), 1, 'Example 1';
is odd_one_out('rat', 'cab', 'dad'), 3, 'Example 2';
is odd_one_out('x', 'y', 'z'), 0, 'Example 3';

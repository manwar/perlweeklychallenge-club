#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub string_score($str) {
    my $score = 0;

    while ($str =~ /(.)(?=(.))/g) {
        $score += abs(ord($1) - ord($2));
    }
    return $score
}

use Test::More tests => 3 + 2;

is string_score('hello'), 13, 'Example 1';
is string_score('perl'), 30, 'Example 2';
is string_score('raku'), 37, 'Example 3';

is string_score(""), 0, 'Empty';
is string_score('a'), 0, 'Single character';

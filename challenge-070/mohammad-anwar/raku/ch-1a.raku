#!/usr/bin/env raku

#
# Perl Weekly Challenge - 070
#
# Task #1: Character Swapping
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-070
#

use Test;

is swap('perlandraku', 3, 4),
   'pndraerlaku',
   'testing perlandraku.';

is swap('weeklychallenge', 5, 2),
   'wklycheeallenge',
   'testing weeklychallenge.';

done-testing;

sub swap(Str $string, Int $count, Int $offset) {

    my $length = $string.chars;
    my @array  = $string.comb;
    for 1..$count -> $i {
        my $a = $i % $length;
        my $b = ($i + $offset) % $length;
        (@array[$a], @array[$b]) = (@array[$b], @array[$a]);
    }

    return @array.join('');
}

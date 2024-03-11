#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Algorithm::Combinatorics qw{ permutations };
use List::Util qw{ uniq };

sub dictionary_rank($word) {
    my @words = uniq(map join("", @$_), permutations([sort split //, $word]));
    for my $i (0 .. $#words) {
        return $i + 1 if $words[$i] eq $word;
    }
}

use Test::More tests => 3;

is dictionary_rank('CAT'), 3, 'Example 1';
is dictionary_rank('GOOGLE'), 88, 'Example 2';
is dictionary_rank('SECRET'), 255, 'Example 3';

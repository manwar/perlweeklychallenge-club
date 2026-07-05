#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max };

my @VOWEL = qw( a e i o u );
my @CONSONANT = grep { my $c = $_; ! grep $_ eq $c, @VOWEL } 'a' .. 'z';

sub sum_of_frequencies($str) {
    my %freq;
    ++$freq{$_} for split //, $str;
    return max(0, grep defined, @freq{@VOWEL})
         + max(0, grep defined, @freq{@CONSONANT})
}

use Test::More tests => 5 + 1;

is sum_of_frequencies('banana'), 5, 'Example 1';
is sum_of_frequencies('teestett'), 7, 'Example 2';
is sum_of_frequencies('aeiouuaa'), 3, 'Example 3';
is sum_of_frequencies('rhythm'), 2, 'Example 4';
is sum_of_frequencies('x'), 1, 'Example 5';

is sum_of_frequencies(""), 0, 'Empty';

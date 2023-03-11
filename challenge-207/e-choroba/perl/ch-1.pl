#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

my $i = 0;
my %ROW = map { ++$i; map { $_ => $i } split // }
          qw( qwertyuiop asdfghjkl zxcvbnm );

sub keyboard_word(@words) {
    return [grep is_single_row($_), @words]
}

sub is_single_row($word) {
    my %rows;
    @rows{ @ROW{ split //, lc $word } } = ();
    return 1 == keys %rows
}

use Test2::V0;
plan 2;

is keyboard_word(qw( Hello Alaska Dad Peace )), [qw[ Alaska Dad ]], 'Example 1';
is keyboard_word(qw( OMG Bye )), [], 'Example 2';

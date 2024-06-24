#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub broken_keys($sentence, @keys) {
    my @words = split ' ', $sentence;
    my $broken = join "", @keys;
    $broken = "[$broken]";
    return grep ! /$broken/i, @words
}

use Test::More tests => 4;

is broken_keys('Perl Weekly Challenge','l', 'a'), 0, 'Example 1';
is broken_keys('Perl and Raku','a'), 1, 'Example 2';
is broken_keys('Well done Team PWC','l', 'o'), 2, 'Example 3';
is broken_keys('The joys of polyglottism','T'), 2, 'Example 4';

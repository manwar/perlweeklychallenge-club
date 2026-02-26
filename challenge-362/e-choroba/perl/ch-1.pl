#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub echo_chamber($string) {
    my $i = 1;
    return join "", map $_ x $i++, split //, $string
}

use Test::More tests => 5 + 1;

is echo_chamber('abca'), 'abbcccaaaa', 'Example 1';
is echo_chamber('xyz'), 'xyyzzz', 'Example 2';
is echo_chamber('code'), 'coodddeeee', 'Example 3';
is echo_chamber('hello'), 'heelllllllooooo', 'Example 4';
is echo_chamber('a'), 'a', 'Example 5';

is echo_chamber(""), "", 'Empty';

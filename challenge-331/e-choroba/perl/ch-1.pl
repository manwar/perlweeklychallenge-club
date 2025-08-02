#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub last_word($str) {
    length +($str =~ /(\w+)/g)[-1]
}

use Test::More tests => 3 + 1;

is last_word('The Weekly Challenge'), 9, 'Example 1';
is last_word('   Hello   World    '), 5, 'Example 2';
is last_word("Let's begin the fun"),  3, 'Example 3';

is last_word("Let's"), 1, 'Word is a Perl word';

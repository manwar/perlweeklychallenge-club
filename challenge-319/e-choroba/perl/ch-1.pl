#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub word_count(@list) {
    scalar grep /^[aeiou]|[aeiou]$/, @list
}

use Test::More tests => 3;

is word_count('unicode', 'xml', 'raku', 'perl'), 2, 'Example 1';
is word_count('the', 'weekly', 'challenge'), 2, 'Example 2';
is word_count('perl', 'python', 'postgres'), 0, 'Example 3';

#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::MoreUtils qw{ nsort_by };

sub sort_language($lang, $popularity) {
    [@$lang[ nsort_by { $popularity->[$_] } 0 .. $#$popularity ]]
}

use Test::More tests => 2;

is_deeply sort_language(['perl', 'c', 'python'], [2, 1, 3]),
    ['c', 'perl', 'python'],
    'Example 1';

is_deeply sort_language(['c++', 'haskell', 'java'], [1, 3, 2]),
    ['c++', 'java', 'haskell'],
    'Example 2';

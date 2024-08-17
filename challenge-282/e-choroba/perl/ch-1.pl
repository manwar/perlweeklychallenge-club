#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub good_integer($int) {
    if ($int =~ /(?:^                 # Start at the beginning
                    | (.) (?! \1 ) )  # or after a digit not followed by itself.
                 ( (.) \3{2}          # Find a digit repeated 3 times
                   (?! \3 )           # but not more.
                 ) /x
    ) {
        return $2
    } else {
        return -1
    }
}

use Test2::V0;
plan tests => 3 + 5;

is good_integer(12344456), '444', 'Example 1';
is good_integer(1233334), '-1', 'Example 2';
is good_integer(10020003), '000', 'Example 3';

is good_integer(111222), in_set('111', '222'), 'More than one group';
is good_integer(1112), '111', 'Beginning';
is good_integer(1222), '222', 'End';
is good_integer(111), '111', 'Everything';
is good_integer(11223344), -1, 'Nothing';

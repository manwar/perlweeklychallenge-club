#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub b_after_a($str) {
    $str =~ /^           # Start of the string.
             [^b]*       # Anything up to the first b.
             b           # The first b.
             (?!         # Not folllowed by...
                 .*      # ... anything...
                 a       # ... and a.
             )
            /x
}

use Test::More tests => 4;

ok b_after_a('aabb'), 'Example 1';
ok ! b_after_a('abab'), 'Example 2';
ok ! b_after_a('aaa'), 'Example 3';
ok b_after_a('bbb'), 'Example 4';

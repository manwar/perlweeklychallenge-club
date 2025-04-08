#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub circular(@list) {
    my $char = "";
    for my $word (@list) {
        return unless 0 == index $word, $char;

        $char = substr $word, -1;
    }
    return 1
}

use Test2::V0;
plan(3 + 1);

is circular('perl', 'loves', 'scala'), bool(1), 'Example 1';
is circular('love', 'the', 'programming'), bool(0), 'Example 2';
is circular('java', 'awk', 'kotlin', 'node.js'), bool(1), 'Example 3';

is circular(qw( matlab basic c c cobol lisp )), bool(1), 'Single char';

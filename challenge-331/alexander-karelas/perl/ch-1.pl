#!/usr/bin/env perl

use v5.42;

use Test2::V0;

sub ll ($string) {
    my ($word) = $string =~ /(\w+)\s*\z/;
    return length $word;
}

is ll("The Weekly Challenge"), 9, 'Example 1';
is ll("   Hello   World    "), 5, 'Example 2';
is ll("Let's begin the fun"), 3, 'Example 3';

done_testing;

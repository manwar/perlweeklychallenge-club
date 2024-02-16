#!/usr/bin/env perl

# The Weekly Challenge 256 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-256/
#
# Task 2 - Merge Strings
#

use strict;
use warnings;
use v5.28;
use List::MoreUtils qw (mesh);

my @examples = (
    [ 'abcd',  '1234' ],
    [ 'abc',   '12345' ],
    [ 'abcde', '123' ],
);

sub merge_strings {
    my @str1 = split(//, shift);
    my @str2 = split(//, shift);
    my @merged = grep { defined $_ } mesh(@str1, @str2);

    return join('', @merged);
}

for my $elements (@examples) {
    my $ms = merge_strings @$elements[0], @$elements[1];

    #    say 'Input : @nums = ', dump(@$elements);
    printf "Input: str1 = %s str2 = %s\n", @$elements[0], @$elements[1];
    say 'Output : ', $ms;
    say ' ';
}

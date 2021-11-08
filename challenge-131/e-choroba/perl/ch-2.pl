#!/usr/bin/perl
use warnings;
use strict;

sub find_pairs {
    my ($pairs, $string) = @_;
    my ($left, $right) = ("", "");
    length($pairs) % 2 ? $right : $left .= substr $pairs, 0, 1, ""
        while length $pairs;

    return [join("", $string =~ /([\Q$left\E])/g),
            join("", $string =~ /([\Q$right\E])/g)]
}

use Test2::V0;
plan 2;

is find_pairs('""[]()',
              '"I like (parens) and the Apple ][+" they said.'),
    ['"(["', '")]"'],
    'Example 1';

is find_pairs('**//<>',
              '/* This is a comment (in some languages) */ <could be a tag>'),
    ['/**/<', '/**/>'],
    'Example 2';

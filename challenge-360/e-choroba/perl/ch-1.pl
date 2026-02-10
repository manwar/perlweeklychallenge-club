#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub text_justifier($str, $width) {
    my $length = length $str;
    my $left_stars = int(($width - $length) / 2);
    my $right_stars = $width - $length - $left_stars;
    $_ < 0 and $_ = 0 for $left_stars, $right_stars;
    return '*' x $left_stars . $str . '*' x $right_stars
}

use Test::More tests => 6 + 1;

is text_justifier("Hi", 5), "*Hi**", "Example 1";
is text_justifier('Code', 10), '***Code***', 'Example 2';
is text_justifier('Hello', 9), '**Hello**', 'Example 3';
is text_justifier('Perl', 4), 'Perl', 'Example 4';
is text_justifier('A', 7), '***A***', 'Example 5';
is text_justifier("", 5), '*****', 'Example 6';

is text_justifier('The Weekly Challenge', 5), 'The Weekly Challenge',
    'Too long';

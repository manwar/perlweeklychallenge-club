#!/usr/bin/env perl

# The Weekly Challenge 281 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-281/
#
# Task 1 - Check Color
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = ( 'd3', 'g5', 'e6');

sub check_color {
    my $coordinates = shift;

    return ($coordinates =~ /[aceg][1357]/) ? 'false' : 'true';

}

for my $elements (@examples) {
    my $cc = check_color $elements;

    say 'Input : coordinates = ', $elements;
    say 'Output : ', $cc;
    say ' ';
}

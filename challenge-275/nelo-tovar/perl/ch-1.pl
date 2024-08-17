#!/usr/bin/env perl

# The Weekly Challenge 275 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-275/
#
# Task 1 - Broken Keys
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    {sentence => "Perl Weekly Challenge", keys => ['l', 'a'] },
    {sentence => "Perl and Raku", keys => ['a']},
    {sentence => "Well done Team PWC", keys => ['l', 'o']},
    {sentence => "The joys of polyglottism", keys => ['T']},
);

sub broken_keys {
    my $e = shift;
    my @words = split(/\W+/,lc($e->{sentence}));
    my $keys = lc(join('', $e->{keys}->@*));

    return scalar grep(!/[$keys]/, @words)
}

for my $elements (@examples) {
    my $bk = broken_keys $elements;

    printf "Input : sentence = '%s' keys = %s\n", $elements->{sentence}, dump($elements->{keys});
    say 'Output : ', $bk;
    say ' ';
}

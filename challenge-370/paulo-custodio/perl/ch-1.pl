#!/usr/bin/env perl

# Perl Weekly Challenge 370 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-370/

use Modern::Perl;

my @words = read_words();
my @banned = read_words();
my %banned; $banned{$_}++ for @banned;
my @popular = grep {!$banned{$_}} @words;
my %popular; $popular{$_}++ for @popular;
@popular = sort {$popular{$b} <=> $popular{$a}} @popular;
say shift(@popular);

sub read_words {
    my @words = map {lc} split /\W+/, scalar(<>);
    return @words;
}

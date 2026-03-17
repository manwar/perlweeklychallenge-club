#!/usr/bin/env perl

# Perl Weekly Challenge 255 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-255/

use Modern::Perl;

my($banned, @paragraph) = @ARGV;
my %count;
my @words =
    map { $_->[0] }
    sort { $b->[1] <=> $a->[1] }
    map { [$_, $count{$_}++] }
    grep { lc($banned) ne lc($_) }
    split /\W/, "@paragraph";
say $words[0];

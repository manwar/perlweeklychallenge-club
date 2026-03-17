#!/usr/bin/env perl

# Perl Weekly Challenge 245 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-245/

use Modern::Perl;

@ARGV or die "Usage: $0 lang pop lang pop ...\n";
my @lang;
while (@ARGV) {
    my($lang, $pop) = splice(@ARGV, 0, 2);
    push @lang, [$lang, $pop];
}
@lang = map {$_->[0]} sort {$a->[1] <=> $b->[1]} @lang;
say "@lang";

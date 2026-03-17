#!/usr/bin/env perl

# Perl Weekly Challenge 317 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-317/

use Modern::Perl;

my @words = split ' ', <>;
chomp(my $word = <>);
my $acronym = join '', map {substr($_,0,1)} @words;
say $word eq $acronym ? "true" : "false";

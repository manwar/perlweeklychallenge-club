#!/usr/bin/env perl

# Perl Weekly Challenge 230 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-230/

use Modern::Perl;

my($prefix, @words) = @ARGV;
say scalar grep {/^$prefix/} @words;

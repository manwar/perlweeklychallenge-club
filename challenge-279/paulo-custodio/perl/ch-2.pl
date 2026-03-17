#!/usr/bin/env perl

# Perl Weekly Challenge 279 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/

use Modern::Perl;

my $str = "@ARGV";
my $vowels = $str =~ tr/aeiouAEIOU/aeiouAEIOU/;
say $vowels % 2 == 0 ? "true" : "false";    # actual splitting is not necessary

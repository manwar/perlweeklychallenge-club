#!/usr/bin/env perl

# Perl Weekly Challenge 213 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-213/

use Modern::Perl;

my @even = sort {$a<=>$b} grep {$_%2==0} @ARGV;
my @odd = sort {$a<=>$b} grep {$_%2!=0} @ARGV;
my @result = (@even, @odd);
say "(", join(", ", @result), ")";

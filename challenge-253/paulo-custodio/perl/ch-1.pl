#!/usr/bin/env perl

# Perl Weekly Challenge 253 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-253/

use Modern::Perl;

my($sep, @words) = @ARGV;
my $words = join($sep, @words);
@words = grep {$_ ne ''} split /\Q$sep/, $words;
say "(", join(", ", @words), ")";

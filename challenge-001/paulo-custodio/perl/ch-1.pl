#!/usr/bin/env perl

# Perl Weekly Challenge 001 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-001/

use Modern::Perl;

my $s = @ARGV ? "@ARGV" : "Perl Weekly Challenge";
say(($s =~ tr/e/E/), " ", $s);

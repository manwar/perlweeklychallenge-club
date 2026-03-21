#!/usr/bin/env perl

# Perl Weekly Challenge 219 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-219/

use Modern::Perl;

say "(", join(", ", sort {$a<=>$b} map {$_*$_} @ARGV), ")";

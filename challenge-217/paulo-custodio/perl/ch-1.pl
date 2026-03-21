#!/usr/bin/env perl

# Perl Weekly Challenge 217 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-217/

use Modern::Perl;

say((sort {$a<=>$b} split ' ', "@ARGV" =~ s/\D/ /gr)[2]);

#!/usr/bin/env perl

# Perl Weekly Challenge 272 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-272/

use Modern::Perl;

$_ = shift // "";
say s/\./[.]/gr;

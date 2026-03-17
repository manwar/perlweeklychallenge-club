#!/usr/bin/env perl

# Perl Weekly Challenge 311 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-311/

use Modern::Perl;

my $str = shift // "";
$str =~ tr/[a-z][A-Z]/[A-Z][a-z]/;
say $str;

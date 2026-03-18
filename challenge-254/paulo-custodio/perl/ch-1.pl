#!/usr/bin/env perl

# Perl Weekly Challenge 254 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-254/

use Modern::Perl;

my $n = shift || 0;
my $root = $n ** (1/3);
my $have_root = (int($root) == $root);
say $have_root ? 'true' : 'false';

#!/usr/bin/env perl

# Perl Weekly Challenge 358 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-358/

use Modern::Perl;
use List::Util qw(max);

@ARGV or die "usage: $0 strs...\n";
say max(map {/\D/ ? length($_) : 0+$_} @ARGV);

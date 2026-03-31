#!/usr/bin/env perl

# Perl Weekly Challenge 366 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-366/

use Modern::Perl;

@ARGV>=2 or die "usage: $0 word list...\n";
my($word, @list) = @ARGV;
say scalar grep {$word =~ /^$_/} @list;

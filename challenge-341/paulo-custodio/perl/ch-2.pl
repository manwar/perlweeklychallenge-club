#!/usr/bin/env perl

# Perl Weekly Challenge 341 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-341/

use Modern::Perl;

@ARGV==2 or die "usage: $0 word letter\n";
my($word, $letter) = @ARGV;
$word =~ s/(.*?$letter)/reverse $1/e;
say $word;

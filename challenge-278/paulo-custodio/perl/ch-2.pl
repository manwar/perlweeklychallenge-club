#!/usr/bin/env perl

# Perl Weekly Challenge 278 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-278/

use Modern::Perl;

@ARGV==2 or die "Usage: $0 word letter\n";
my($word, $letter) = @ARGV;

say $word =~ s{.*?$letter}{ join '', sort split //, $& }er;

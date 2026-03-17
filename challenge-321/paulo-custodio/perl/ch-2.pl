#!/usr/bin/env perl

# Perl Weekly Challenge 321 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-321/

use Modern::Perl;

@ARGV==2 or die "usage: $0 str1 str2\n";
my($str1, $str2) = @ARGV;
for ($str1, $str2) {
    1 while s/[^#]#//;
}
say $str1 eq $str2 ? "true" : "false";

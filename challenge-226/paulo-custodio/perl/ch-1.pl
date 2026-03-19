#!/usr/bin/env perl

# Perl Weekly Challenge 226 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-226/

use Modern::Perl;

my($str, @idx) = @ARGV;
my @chars = split //, $str;
say join('', map {$_->[1]} sort {$a->[0] <=> $b->[0]} map {[$idx[$_], $chars[$_]]} 0..$#chars);

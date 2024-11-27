#!/bin/perl

=pod

The Weekly Challenge - 271
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-296#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: String Compression
Submitted by: Mohammad Sajid Anwar

You are given a string of alphabetic characters, $chars.

Write a script to compress the string with run-length encoding, as shown in the examples.

A compressed unit can be either a single character or a count followed by a character.

BONUS: Write a decompression function.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

no warnings qw(experimental::signatures);
sub str2rle ($str) {
  $str =~ s#([a-zA-Z])(\1{1,})#$1.length($&)#ger
}

sub rle2str ($rle) {
  $rle =~ s#([a-zA-Z])(\d+)#$1 x $2#ger
}

for ([1,'abbc'],[2,'aaabccc'],[3,'abcc']) {
  is(rle2str(str2rle($$_[1])),$$_[1],"Example $$_[0]");
}

done_testing;

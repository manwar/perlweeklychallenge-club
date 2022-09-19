#!/bin/perl

=pod

The Weekly Challenge - 164
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-166/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Hexadecimal Words
Submitted by: Ryan J Thompson

As an old systems programmer, whenever I needed to come up with a 32-bit number, 
I would reach for the tired old examples like 0xDeadBeef and 0xC0dedBad. I want more!

Write a program that will read from a dictionary and find 2- to 8-letter words that 
can be “spelled” in hexadecimal, with the addition of the following letter substitutions:

    o -> 0 (e.g., 0xf00d = “food”)
    l -> 1
    i -> 1
    s -> 5
    t -> 7

=cut

use v5.16;

use File::Slurp;
use List::Util qw(sum);
use List::MoreUtils qw(uniq);

my $dictFile = shift // '../../../data/dictionary.txt';

# Challenge
printf "Challenge: %-8s => %s\n", $_, tr/olist/01157/r for(hexWords($dictFile));

# Optional 1
printf "Optional 1: %-8s => %s\n", $_, tr/ost/057/r for(hexWords2($dictFile));

# Optional 2
printf "Optional 2: %-8s => %s\n", $_, tr/ost/057/r for(hexPhrase($dictFile));


sub hexWords ($)  {
  my ($dictFile) = @_;

  return grep{chomp && /^[a-folist]{2,8}$/} 
              read_file $dictFile;
}


sub hexWords2 ($) {
  my ($dictFile) = @_;

  return grep{chomp && /^[a-fost]{2,8}$/} 
              read_file $dictFile;
}


sub hexPhrase ($) {
  my ($dictFile) = @_;

  my @res;
  my %hwl; 

  my @hw = grep {/^[^ost][[a-fost]{1,5}$/} hexWords2($dictFile);
  map { push(@{$hwl{length($_)}},$_) } @hw;

  my @l = (
    [2,2,2,2], [2,2,4], [2,3,3], [2,4,2], [2,6], 
    [3,2,3], [3,3,2], [3,5],
    [4,2,2], [4,4], 
    [5,3], 
    [6,2]
  );
  foreach my $ar (@l) {
    foreach my $w (glob '{'.join('}:{', map { join(',', @{$hwl{$_}}) } @$ar).'}') {
      my @w = map { ucfirst } split(/:/,$w);
      $w = join('', @w);
      push(@res, $w) if (length(join('',uniq(@w))) == 8);
    }
  }

  return @res;
}

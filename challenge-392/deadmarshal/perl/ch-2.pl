#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(any max);
use Test::More tests => 5;

sub common_letters{
  my ($s1,$s2) = @_;
  my %h = map{$_ => 1} split '',$s1;
  any {$h{$_}} split '',$s2
}

sub words_length_product{
  my ($words) = @_;
  my $best = 0;
  foreach my $i(0..$#$words-1) {
    foreach my $j($i+1..$#$words) {
      my ($w1,$w2) = @{$words}[$i,$j];
      next if common_letters($w1,$w2);
      $best = max($best,length($w1) * length($w2))
    }
  }
  $best
}

is words_length_product(["a","ab","abc","d","de","def"]),9,
  'Example 1';
is words_length_product(["a","aa","aaa","aaaa"]),0,'Example 2';
is words_length_product(["meet","app","code","sky","bold"]),16,
  'Example 3';
is words_length_product(["a","ab","abc","abcd","efghi"]),20,
  'Example 4';
is words_length_product(["xyz","w","abcdefg","hij"]),21,'Example 5';

done_testing();


#!/bin/perl

=pod

The Weekly Challenge - 190
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-190/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Decoded List
Submitted by: Mohammad S Anwar

You are given an encoded string consisting of a sequence of numeric
characters: 0..9, $s.

Write a script to find the all valid different decodings in sorted order.

|| Encoding is simply done by mapping A,B,C,D,... to 1,2,3,4,... etc.

=cut

use v5.16;
use warnings;

use Test::More;
use Test::Deep qw(cmp_deeply);

use List::MoreUtils qw(all firstidx);
use Algorithm::Permute;



sub decodedList ($) {
  state $d = {map { (ord($_) - ord('A') + 1, $_) } 'A' .. 'Z'};

  my %res;
  my $len = length($_[0]);

  # Create substring length list of lists
  my @l = ([(2) x ($len >> 1), (1) x ($len % 2)]);
  while (1) {
    my @a = @{$l[-1]};
    my $i = firstidx {$_ == 2} @a;
    last if $i == -1;

    splice(@a,$i,1,1,1); 
    push(@l,[@a]);
  }

  # Find and decode the digits
  for (@l) {
    Algorithm::Permute::permute {
      my @p = unpack(join(' ',map { "a$_" } @$_),$_[0]);
      if (all { defined $d->{$_} } @p) {
        $res{join('',map { $d->{$_} } @p)}++;
      }
    } @$_;
  }

  return [sort keys %res];
}



cmp_deeply(decodedList('11'),[qw(AA K)]);
cmp_deeply(decodedList('1115'),[qw(AAAE AAO AKE KAE KO)]);
cmp_deeply(decodedList('127'),[qw(ABG LG)]);

done_testing;

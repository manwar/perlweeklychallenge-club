#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

my @rs = rank_score(@ARGV ? @ARGV : (2, 5, 2, 1, 7, 5, 1));
say '(', join(',', @rs), ')';

sub rank_score (@scores) {
   state $lower = [ qw< X G S B > ];
   my @retval = (0) x @scores;
   my $n = 0;
   my @pairs = reverse sort { $a->[0] <=> $b->[0] }
      map { [$scores[$_], $_] }
      0 .. $#scores;
   for my $i (0 .. $#pairs) {
      my ($v, $k) = $pairs[$i]->@*;
      $n = $i + 1 if $i == 0 || $pairs[$i - 1][0] > $v;
      $retval[$k] = $n < 4 ? $lower->[$n] : $n;
   }
   return @retval;
}

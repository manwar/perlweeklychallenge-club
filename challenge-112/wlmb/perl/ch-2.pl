#!/usr/bin/env perl
# Perl weekly challenge 112
# Task 2: Climb stairs. Count ways.
#
# See https://wlmb.github.io/2021/05/12/PWC112/#task-2-climb-stairs
  use strict;
  use warnings;
  use v5.12;
  use Memoize;
  foreach my $n(@ARGV){ # Number of steps from @ARGV
      my $ways=0;
      foreach my $n2(0..$n/2){
	  my $n1=$n-2*$n2;
	  $ways+=factorial($n1+$n2)/(factorial($n1)*factorial($n2));
      }
      say "Input: $n  Output: $ways";
  }

memoize('factorial');
sub factorial {
    my $x=shift @_; #assume non-negative integer
    return 1 if $x==0 or $x==1;
    return $x*factorial($x-1);
}

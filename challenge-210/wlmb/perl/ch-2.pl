#!/usr/bin/env perl
# Perl weekly challenge 210
# Task 2:  Number Collision
#
# See https://wlmb.github.io/2023/03/27/PWC210/#task-2-number-collision
use v5.36;
use List::Util qw(first);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    To find which numbers among N1 N2... survive all collisions
    FIN
my @numbers=@ARGV; # copy input
while(defined( # search for index of next collision
	  my $collision=first {
	      $numbers[$_]>$numbers[$_+1] && $numbers[$_]>=0>=$numbers[$_+1]
	      }
	      0..@numbers-2
      )
    ){
    splice @numbers, $collision + 1, 1  if $numbers[$collision] > -$numbers[$collision+1];
    splice @numbers, $collision, 1      if $numbers[$collision] < -$numbers[$collision+1];
    splice @numbers, $collision, 2      if $numbers[$collision] == -$numbers[$collision+1];
}
say "(@ARGV) -> (@numbers)"

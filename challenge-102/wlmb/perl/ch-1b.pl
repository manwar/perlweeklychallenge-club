#!/usr/bin/env perl
# Perl weekly challenge 102
# Task 1: Rare numbers
# Slightly faster through a reduction of the search space, but more elaborate.
#
# See https://wlmb.github.io/2021/03/01/PWC102/#task-2-rare-numbers
use strict;
use warnings;
use v5.12;
use integer;
use POSIX qw(floor);

for my $N(@ARGV){
    my ($min, $max)=(10**($N-1), 10**$N-1);
  A:
    for my $a(floor(sqrt($min))..floor(sqrt(2*$max))){
      B:
	for my $b(1..$a){
	    my $x=($a**2+$b**2);
	    next B unless $x%2==0;
	    $x/=2;
	    next B if $x<$min;
	    next A if $x>$max;
	    my $y=join '', reverse split '', $x;
	    next B unless $y==($a**2-$b**2)/2;
	    my ($s, $d)=($x+$y, $x-$y);
	    say "N=$N\tx=$x\ty=$y\tx+y=$s=", sqrt($s),"**2\tx-y=$d=",sqrt($d),"**2";
      }
  }
}

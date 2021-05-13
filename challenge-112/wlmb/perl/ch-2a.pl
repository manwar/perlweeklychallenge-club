#!/usr/bin/env perl
# Perl weekly challenge 112
# Task 2: Climb stairs. List ways.
#
# See https://wlmb.github.io/2021/05/12/PWC112/#task-2-climb-stairs
  use strict;
  use warnings;
  use v5.12;
  use List::Util qw(sum0);
  foreach my $n(@ARGV){  # Number of steps from @ARGV
      say "\nInput: $n\nCombinations:";
      foreach my $n2(0..$n/2){
	  my $n1=$n-2*$n2;
	  my $total=$n1+$n2;
	  my $combinator=combinator($total, $n1);
	  while(my @combination=$combinator->()){
	      say join ",", map {$_==0?"double":"single"} @combination;
	  }
      }
  }

  sub combinator { # produces combinations of n taken k at a time
      my ($n,$k)=@_;
      my @number=((1) x $k, (0) x ($n-$k)); # binary $n-bit number as array
      my $done=0;
      my $iter=0;
      sub { #dumb but simple
	  return if $done;
	  return @number if $iter++==0; #first time through
	  while(increment(@number)){
	      return @number if sum0(@number)==$k;
	  }
	  $done=1;
	  return;
      }
  }

  sub increment {
      $_[0]++; #use @_ directly to modify it
      for(0..@_-2){
	  return @_ if $_[$_] < 2;
	  $_[$_]=0;  #carry to next digit
	  ++$_[$_+1];
      }
      return @_ if $_[-1] < 2;
  }

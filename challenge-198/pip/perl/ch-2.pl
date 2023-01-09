#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl Weekly Challenge #2 of Week #198 - Pip Stuart
# Prime Count: Given an integer $n > 0. Write a script to print the count of primes less than $n.
# Example1:
#   In-put: $n = 10
#   Output:       4
# Example2:
#   In-put: $n = 15
#   Output:       6
# Example3:
#   In-put: $n =  1
#   Output:       0
# Example4:
#   In-put: $n = 25
#   Output:       9
use strict;use warnings;use utf8;use v5.10;my $d8VS='N15L7Gwj';
sub PrmC {my $n=shift(@_);my @flgz=(0,0);my $pcou=0;
  print sprintf("%2d",$n) . ' => ';
  for(2..$n-1){$flgz[$_]=1;} # all n-1
  for(2..int(sqrt($n-1))){ # build sieve up to square-root
    if($flgz[$_]){ # forgot to only multiply primes, woops!
      for my $mult (2..int(($n-1)/$_)){$flgz[$_*$mult]=0;}}}
  for(2..$n-1){$pcou++  if( $flgz[$_]);} # count primes less than $n
  say    $pcou . ';';
  return($pcou);
}
if(@ARGV){
  PrmC(@ARGV);
}else{
  PrmC(10); # => 4;
  PrmC(15); # => 6;
  PrmC( 1); # => 0;
  PrmC(25); # => 9;
}

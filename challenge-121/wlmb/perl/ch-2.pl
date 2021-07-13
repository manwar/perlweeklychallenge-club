#!/usr/bin/env perl
# Perl weekly challenge 121
# Task 2: The travelling salesman
#
# See https://wlmb.github.io/2021/07/12/PWC121/#task-2-the-travelling-salesman
use strict;
use warnings;
use v5.12;
use PDL; # Perl data language

foreach(@ARGV){
    #Assume the matrix is of the form [[m00,m01,m02..],[m10,m11,...]...]
    my $M=pdl($_);
    say("Require square matrix"), next unless $M->ndims==2 and $M->dim(0)==$M->dim(1);
    say("Self distances should be null"), next unless all($M->diagonal(0,1)==0);
    my $N=$M->dim(0); # number of cities
    my $iterate=permutator($N);
    my $best_tour;
    my $shortest_length;
    while(my @cities=$iterate->()){ # for each possible trip
	my $tour=pdl(@cities);
	my $indices=pdl($tour->rotate(-1), $tour)->transpose; #pair next city to current city
	my $length=$M->indexND($indices)->sumover; # get distances for this trip and sum
	($best_tour, $shortest_length)=($tour, $length)
	    if !defined $shortest_length || $length<$shortest_length;
    }
    $best_tour=append($best_tour,0); #go back to the first city
    say "\nInput $M\nBest tour: $best_tour\nShortest length: $shortest_length";
    say("Strange metric: Length A->B not equal Length B->A")
        unless all $M==$M->transpose;
}

  sub permutator { #returns an iterator for permutations
      my $n_items=(shift)-1;
      my @items=1..$n_items;
      my $n=0;
      my $done=0;
      sub {
	  return if $done;
	  my $which=$n; #next item to transpose
	  return 0,@items if $n++ == 0; #return first time through
	  my $with_whom=1; #with whom to permute
	  while($with_whom<=$n_items&&$which%$with_whom==0){
	      $which/=$with_whom;
	      ++$with_whom;
	  }
	  $done=1, return if $with_whom >$n_items; #no more transpositions
	  $which=$with_whom-$which%$with_whom;
	  #use negative indices to transpose rightmost first
	  @items[-$with_whom+1..-1]=reverse @items[-$with_whom+1..-1]; #reorder
	  @items[-$which,-$with_whom]=@items[-$with_whom,-$which]; # transpose
	  return 0,@items
      }
  }

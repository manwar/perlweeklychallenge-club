#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

sub find_subarray_sum {
   my $array = shift ;
   my $len = shift ;
   if ( $len == 1 || $len == scalar( @$array ) ) {
      return sum( @$array ) ;
   }
   else {
      my $total = 0 ;
      my $arraylen = scalar( @$array ) ;
      for my $start( 0..$arraylen - $len) {
	 my $currentSum = sum( @{$array}[$start..$start + $len - 1] ) ;
	 $total += $currentSum ;
      }
      return $total ;
   }
}

say "Enter some positive integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @sums ;
for my $i( 1..scalar( @numbers ) ) {
   if ( $i % 2 == 1 ) {
      push( @sums , find_subarray_sum( \@numbers , $i )) ;
   }
}
say sum( @sums ) ;

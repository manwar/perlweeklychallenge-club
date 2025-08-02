#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

sub count {
   my $array = shift ;
   my $elt = shift ;
   return scalar( grep { $_ == $elt } @$array ) ;
}

say "Enter some 0 and 1 separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $first = $numbers[0] ;
if ( all { $_ == $first } @numbers ) {
   say 0 ;
}
else {
   my $len = scalar( @numbers ) ;
   my @pairs ;
   for my $start( 0..$len - 2 ) {
      for my $end ( $start + 1 .. $len - 1 ) {
	 my @subarray = @numbers[$start..$end] ;
	 my $count_ones = count( \@subarray , 1 ) ;
	 my $count_zeroes = $end + 1 - $start - $count_ones ;
	 push( @pairs , [$count_ones, $count_zeroes] ) ;
      }
   }
   my @selected = grep { $_->[0] == $_->[1] } @pairs ;
   if ( @selected ) {
      my @sorted = sort { $a->[0] <=> $b->[0] } @selected ;
      my $sel = scalar( @selected ) ;
      say ( $sorted[$sel - 1]->[0] + $sorted[$sel - 1]->[1] ) ;
   }
   else {
      say 0 ;
   }
}


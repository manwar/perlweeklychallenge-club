#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

#create an array of neighbouring numbers , where each partial array
#has a given length
sub findNeighbours {
   my $target = shift ;
   my $len = shift ;
   my @neighbours ;
   for my $start( 0..scalar(@$target) - $len) {
      my @row ;
      for my $i( $start..$start + $len - 1) {
	 push( @row , $target->[$i] ) ;
      }
      push( @neighbours, \@row ) ;
   }
   return @neighbours ;
}

say "Enter some integers separated by blanks, <return> to end!" ;
my $line = <STDIN> ;
chomp $line ;
my @source ;
while ( $line ) {
   my @row = split( /\s/ , $line ) ;
   push( @source , \@row ) ;
   say "Enter some integers separated by blanks, <return> to end!" ;
   $line = <STDIN> ;
   chomp( $line ) ;
}
say "Enter some integers to denote the target!" ;
my $targetline = <STDIN> ;
chomp $targetline ;
my @target = split( /\s/ , $targetline ) ;
#the condition can't be fulfilled if the total number of integers in source
#is not equal to the number in @target
my $totallen = 0 ;
for my $el( @source ) {
   $totallen += scalar( @$el ) ;
}
if ( $totallen != scalar( @target ) ) {
   say "false" ;
}
else {
#the strategy is : create an array of neighbouring numbers and see whether
#a given array of @source is contained in it. If so , we add a 1 to 
#@results and in the end check whether all elements in @results are equal
#to 1. In order to compare subarrays I stringify them in the convert 
#function
   my @results ; 
   for my $el( @source ) {
      my @neighbours = findNeighbours( \@target , scalar( @$el ) ) ;
      my %targethash ;
      for my $found( @neighbours ) {
	 $targethash{convert( $found )}++ ;
      }
      if ( exists( $targethash{ convert( $el ) })) {
	 push( @results , 1 ) ;
      }
      else {
	 push( @results , 0 ) ;
      }
   }
   if ( all { $_ == 1 } @results ) {
      say "true" ;
   }
   else {
      say "false" ;
   }
}

sub convert {
   my $element = shift ;
   if ( scalar( @$element) == 1 ) {
      return $element->[0] . '|' ;
   }
   else {
      return join( '|' , @$element ) ;
   }
}

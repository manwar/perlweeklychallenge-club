#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub isNeighbouring {
   my $firstArray = shift ;
   my $secondArray = shift ;
   my %firstHash ;
   my %secondHash ;
   map { $firstHash{$_}++ } @$firstArray ;
   map { $secondHash{$_}++ } @$secondArray ;
   for my $i ( keys %firstHash ) {
      if ( exists( $secondHash{ $i } )) {
	 return 1 ;
      }
   }
   return 0 ;
}

sub contains {
   my $array = shift ;
   my $element = shift ;
   for my $elt( @$array ) {
      if ( $elt == $element ) {
	 return 1 ;
      }
   }
   return 0 ;
}

say "Enter some positive integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
if ( $numbers[0] == 0 ) { #we don't get to the last item
   say -1 ;
}
elsif ( $numbers[0] >= $len - 1 ) { #only one big jump!
   say 1 ;
}
else {
   my @allIndices ; #collection of all indices attainable from an index
   my @currentIndices ;#all positions attainable from a given index
   for my $i ( 0 .. $len - 1 ) {
      if ( $numbers[$i] == 0 ) {
	 push( @currentIndices , $i ) ;
      }
      else {
	 for my $p (0..$numbers[$i]) {
	    push( @currentIndices , $i + $p ) ;
	 }
      }
      my @tempArray ;
      map { push( @tempArray , $_ ) } @currentIndices ;
      push( @allIndices , \@tempArray ) ;
      @currentIndices = ( ) ;
   }
   my @neighbours ; #if neighbouring index lists have elements in common
#they go here
   push( @neighbours , $allIndices[0] ) ;
   for my $i( 1..$len - 1 ) {
      if ( contains( $neighbours[-1] , $len - 1 ) ) {
	 last ;
      }
      if ( scalar( @{$allIndices[$i]} > 1) && 
	       isNeighbouring( $neighbours[-1] , $allIndices[ $i ] ) ) {
	 push( @neighbours , $allIndices[ $i ] ) ;

      }
   }
   if ( not contains( $neighbours[-1] , $len - 1 ) ) {
      say -1 ;
   }
   else {
      say scalar( @neighbours ) ;
   }
}

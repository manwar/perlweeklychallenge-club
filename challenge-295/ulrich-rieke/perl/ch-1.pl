#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

sub findIntersection {
   my $firstArray = shift ;
   my $secondArray = shift ;
   my @common ;
   my %firstHash ;
   map { $firstHash{$_}++ } @$firstArray ;
   for my $elt( @$secondArray ) {
      if ( exists( $firstHash{$elt} ) ) {
	 push( @common , $elt ) ;
      }
   }
   return @common ;
}

say "Enter a long word!" ;
my $word = <STDIN> ;
chomp $word ;
say "Enter some words separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
unless ( all { $word =~ /$_/ } @words ) {
   say "false" ;
}
else {
   my @allIndices ; #for all the indices of the given single words in long w.
   for my $w ( @words ) {
      my $pos = index( $word , $w ) ;
      while ( $pos != -1 ) {#find all occurrences of a word
	 my @array = ($pos..$pos + (length( $w ) - 1)) ;
	 push( @allIndices , \@array ) ;
	 if ( $pos < length( $word ) - 1 ) {
	    $pos++ ;
	 }
	 $pos = index( $word , $w , $pos ) ;
      }
   }
#now we see if there are any intersections between the index ranges
#if so, the result is false
   my $result = "true" ;#assume it to be right!
   for my $i ( 0..scalar( @allIndices ) - 2 ) {
      if ( findIntersection( $allIndices[$i] , $allIndices[$i + 1] ) ) {
	 $result = "false" ; #unless proven false
	 last ;
      }
   }
   say $result ;
}

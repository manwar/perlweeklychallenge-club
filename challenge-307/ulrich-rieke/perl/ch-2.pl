#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub findAnagramNumber {
   my $words = shift ;
   my $anagramCount = 0 ;
   my $len = scalar( @$words ) ;
   for my $pos( 0..$len - 2 ) {
      if ( areAnagrams( $words->[$pos] , $words->[$pos + 1] ) ) {
	 $anagramCount++ ;
      }
   }
   return $anagramCount ;
}

sub areAnagrams {
   my $first = shift ;
   my $second = shift ;
   my $firstOrdered = join( '' , sort ( split (// , $first )) ) ;
   my $secondOrdered = join( '' , sort ( split (// , $second ))) ;
   if ( $firstOrdered eq $secondOrdered ) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

say "Enter some words separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my $ananumber = findAnagramNumber( \@words ) ;
say ( scalar( @words ) - $ananumber ) ;

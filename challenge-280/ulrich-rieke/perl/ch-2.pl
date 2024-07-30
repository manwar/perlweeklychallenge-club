#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub count {
   my $haystack = shift ;
   my $needle = shift ;
   return scalar( grep { $_ eq $needle } split( // , $haystack ) ) ;
}

say "Enter a string with some bars!" ;
my $line = <STDIN> ;
chomp $line ;
my $barcount = count( $line , '|' ) ;
if ( $barcount <= 1 ) {
   my $result = count( $line , '*' ) ;
   say $result ;
}
else {
   my $barFound = 0 ;
   my $filtered ;
   for my $c ( split( // , $line )) {
      if ( $c ne '|' ) {
	 $filtered .= $c ;
      }
      else {
	 if ( $barFound ) {
	    my $pos = index( $filtered , '|' ) ;
	    $filtered = substr( $filtered , 0 , $pos ) ;
	    $barFound = 0 ;
	 }
	 else {
	    $filtered .= '|' ;
	    $barFound = 1 ;
	 }
      }
   }
   say count( $filtered , '*' ) ;
}

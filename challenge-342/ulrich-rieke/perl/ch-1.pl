#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;
say "Enter a string with lowercase English letters and digits only!" ;
my $word = <STDIN> ;
chomp $word ;
my @letters ;
my @digits ;
for my $l ( split( // , $word ) ) {
   if ( $l =~ /\d/ ) {
      push( @digits , $l ) ;
   }
   else {
      push( @letters , $l ) ;
   }
}
my $lettercount = scalar( @letters ) ;
my $digitcount = scalar( @digits ) ;
if ( abs( $lettercount - $digitcount ) > 1 ) {
   say "\"\"" ;
}
else {
   my @sortedChars = sort @letters ;
   my @sortedDigits = sort @digits ;
   my @solution ;
   if ( $digitcount >= $lettercount ) {
      while ( @sortedDigits ) {
	 push( @solution , shift @sortedDigits ) ;
	 if ( @sortedChars ) {
	    push( @solution , shift @sortedChars ) ;
	 }
      }
   }
   else {
      while( @sortedChars ) {
	 push( @solution , shift @sortedChars ) ;
	 if ( @sortedDigits ) {
	    push( @solution , shift @sortedDigits ) ;
	 }
      }
   }
   say join( '' , @solution ) ;
}




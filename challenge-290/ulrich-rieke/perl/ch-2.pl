#!/usr/bin/perl ;
use strict ; 
use warnings ;
use feature 'say' ;
use POSIX ;
use List::Util qw ( sum ) ;

sub digitsum {
   my $number = shift ;
   my $sum = 0 ;
   while ($number != 0 ) {
      $sum += $number % 10 ;
      $number = floor( int( $number / 10 ) ) ;
   }
   return $sum ;
}

say "Enter a term consisting of digits only!" ;
my $term = <STDIN> ;
chomp $term ;
$term =~ s/\s+//g ;
my $reversed = join( '' , reverse split( // , $term) ) ;
my $payload = substr( $reversed , 0 , 1 ) ;
my @sums ;
my $count = 1 ; 
for my $pos( 1..length $reversed - 1 ) {
   if ( substr( $reversed , $pos , 1 ) =~ /[0-9]/ ) {
      my $number = substr( $reversed , $pos , 1 ) ;
      if ( $count % 2 == 1 ) {
	 my $possum = 2 * $number ;
	 if ( $possum < 10 ) {
	    push( @sums, $possum ) ;
	 }
	 else {
	    my $localsum = digitsum( $possum ) ;
	    push( @sums , $localsum ) ;
	 }
      }
      else {
	 push( @sums, $number ) ;
      }
      $count++ ;
   }
}
my $allSum = sum( @sums ) ;
if ( ($allSum + $payload) % 10 == 0 ) {
   say "true" ;
}
else {
   say "false" ;
}


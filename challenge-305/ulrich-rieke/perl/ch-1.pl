#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#convert from binary to decimal by hand( somehow, I never ever particularly
#liked the pack-unpack duality...!
sub to_decimal {
   my $binary = shift ;
   my $sum = 0 ;
   my $multiply = 1 ;
   my @reversed = reverse( split(// , $binary) ) ;
   for my $number( @reversed ) {
      $sum += $number * $multiply ;
      $multiply *= 2 ;
   }
   return $sum ;
}

sub isPrime {
   my $number = shift ;
   if ( $number == 0 || $number == 1 ) {
      return 0 ;
   }
   elsif ( $number == 2 ) {
      return 1 ;
   }
   else {
      my $limit = int( sqrt( $number ) ) ;
      for my $num( 2..$limit ) {
	 if ( $number % $num == 0 ) {
	    return 0 ;
	    last ;
	 }
      }
      return 1 ;
   }
}

say "Enter some binary strings separated by spaces!" ;
my $line = <STDIN> ;
chomp $line ;
my @binaries = split( /\s/ , $line ) ;
my $binstring ;
my @truth_values ;
my @decimals ;
for my $number( @binaries ) {
   $binstring .= $number ;
   push( @decimals , to_decimal( $binstring )) ;
}
for my $num( @decimals ) {
   if ( isPrime( $num ) ) {
      push( @truth_values , "true" ) ;
   }
   else {
      push( @truth_values , "false" ) ;
   }
}
say '(' . join( ',' , @truth_values ) . ')' ;

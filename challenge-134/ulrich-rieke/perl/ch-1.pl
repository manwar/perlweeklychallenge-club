#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Math::BigInt ;

#the smallest pandigit 10-based number must begin with "10" , the rest of
#the other digits must follow in numerical order ;

sub isPandigital {
  my $number = shift ;
  my %digitCount ;
  my $numstring = $number->bstr( ) ;
  for my $digit ( split ( // , $numstring ) ) {
      $digitCount{ $digit }++ ;
  }
  return ( (scalar ( keys %digitCount )) == 10 ) ;
}

my @panDigitals ;
my $start = Math::BigInt->new( "1023456789" ) ;
my $one = Math::BigInt->new( "1" ) ;
my $current = $start->copy( ) ;
push( @panDigitals , $start ) ;
while ( (scalar @panDigitals) != 5 ) {
  $current = $current->badd( $one ) ;
  if ( isPandigital( $current ) ) {
      push ( @panDigitals , $current ) ;
  }
}
say join( ", " , map { $_->bstr( ) } @panDigitals ) ;

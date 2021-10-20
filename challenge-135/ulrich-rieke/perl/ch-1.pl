#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use feature "switch" ;

my $n = $ARGV[ 0 ] ;
while ( $n !~ /\A[+-]*\d+\z/ ) {
  say "Input should consist of possible sign and numbers only!" ;
  $n = <STDIN> ;
  chomp $n ;
}
my $len = length( $n ) ;
if ( $len == 4 && substr( $n , 0 ,1 ) =~ /\+|\-/ ) {
  say substr( $n , 1 ) ;
}
else {
  given ($len) {
      when ( ($_ % 2 == 0)) { say "even number of digits"  }
      when ( ($_ < 3 ) and not ( $_ % 2 == 0 ) ) { say "too short" }
      when ( ( not ($_ % 2 == 0 ) ) && ( $_ > 3 )) { say
    substr( $n ,  ( $len - 3 )/ 2 , 3 ) }
  }
}

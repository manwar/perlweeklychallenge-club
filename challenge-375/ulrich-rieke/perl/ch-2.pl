#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a number and a k value separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my ( $numberstring , $k ) = split( /\s/ , $line ) ;
my $result ;
my $len = length $numberstring ;
if ( $k == $len ) {
   $result = 1 ;
}
elsif ( $k > $len ) {
   $result = 0 ;
}
else {
   my @numbers ;
   for my $pos( 0..$len - $k) {
      push( @numbers , substr( $numberstring , $pos , $k ) ) ;
   }
   $result = scalar( grep { $numberstring % $_ == 0 } @numbers ) ;
}
say $result ;

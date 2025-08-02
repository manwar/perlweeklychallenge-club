#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( product ) ;

say "Enter some integers, separated by ',' !" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( ',' , $line ) ;
my $prod = product( @numbers ) ;
my $result ;
if ( $prod < 0 ) {
   $result = -1 ;
}
elsif ( $prod == 0 ) {
   $result = 0 ;
}
else {
   $result = 1 ;
}
say $result ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;

say "Enter a number!" ;
my $number = <STDIN> ;
chomp $number ;
my $third = 1 / 3 ;
my $cuberoot = $number ** $third ;
if ( $cuberoot == floor( $cuberoot )) {
   say "true" ;
}
else {
   say "false" ;
}

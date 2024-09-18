#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string!" ;
my $string = <STDIN> ;
chomp $string ;
my $sign = qr/[+\-]??/ ;
my $integer = qr/$sign*\d+/ ;
my $exponent = qr/[eE]$integer/ ;
my $decimal = qr/^$sign*\d+\.$|^$sign*\d+\.\d$|^$sign*\.\d+$/ ;
my $valid = qr/^$integer$exponent*$|^$decimal$exponent*$/ ;
if ( $string =~ /$valid/ ) {
   say "true" ;
}
else {
   say "false" ;
}

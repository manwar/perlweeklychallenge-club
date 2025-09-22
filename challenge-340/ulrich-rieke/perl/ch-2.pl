#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

say "Enter a string with non-digit English letters and numbers only!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s+/ , $line ) ;
my @numbers = grep { $_ =~ /^[1-9][0-9]*$/ } @words ;
my @differences ;
for my $pos ( 1..scalar( @numbers ) - 1 ) {
   push( @differences , $numbers[$pos] - $numbers[$pos - 1] ) ;
} 
if ( all { $_ > 0 } @differences ) {
   say "true" ;
}
else {
   say "false" ;
}

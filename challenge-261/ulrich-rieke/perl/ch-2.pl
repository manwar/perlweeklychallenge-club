#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( any ) ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
say "Enter a start number!" ;
my $start = <STDIN> ;
chomp $start ;
while ( any { $_ == $start } @numbers ) {
   $start *= 2 ;
}
say $start ;

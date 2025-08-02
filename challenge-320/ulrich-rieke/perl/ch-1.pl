#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $positives = scalar( grep { $_ > 0 } @numbers ) ;
my $negatives = scalar( grep { $_ < 0 } @numbers ) ;
if ( $positives != 0 || $negatives != 0 ) {
   say max( $positives , $negatives ) ;
}
else {
   say 0 ;
}

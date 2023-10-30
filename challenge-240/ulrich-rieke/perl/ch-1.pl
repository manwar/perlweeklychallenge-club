#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some words, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
say "Enter a check string!" ;
my $checkstr = <STDIN> ;
chomp $checkstr ;
my $compare ;
for my $st ( @words ) {
   my $toLower = lc( $st ) ;
   $compare .= substr( $toLower , 0 , 1 ) ;
}
if ( $compare eq $checkstr ) {
   say "true" ;
}
else {
   say "false" ;
}

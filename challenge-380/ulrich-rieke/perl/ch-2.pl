#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string!" ;
my $word = <STDIN> ;
chomp $word ;
my $value = 0 ;
my $pos = 1 ;
for my $letter ( split( // , $word )) {
   $value += $pos * ( 123 - ord( $letter ) ) ;
   $pos++ ;
}
say $value ;

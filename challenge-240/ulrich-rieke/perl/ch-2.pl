#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some positive integers, separated by blanks!" ;
say "Numbers should be from 0 to the length of array -1!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @newNumbers ;
my $len = scalar( @numbers ) ;
for my $i ( 0..$len - 1 ) {
   my $num = $numbers[ $i ] ;
   push @newNumbers , $numbers[ $num ] ;
}
say "(" . join( ',' , @newNumbers) . ")" ;

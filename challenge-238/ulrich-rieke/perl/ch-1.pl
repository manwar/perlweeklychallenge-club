#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my $current_sum = 0 ;
my @result ;
for my $i (0..$len - 1 ) {
   $current_sum += $numbers[ $i ] ;
   push @result , $current_sum ;
}
say "(" . join( ',' , @result ) . ")" ;

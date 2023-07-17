#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string!" ;
my $str = <STDIN> ;
chomp $str ;
say "Enter as many numbers as is given by the length of the string!" ;
say "Numbers should be the indices to the string, going from 0 to length - 1!" ;
my $numberstring = <STDIN> ;
chomp $numberstring ;
my @numbers = split( /\s/ , $numberstring ) ;
my @pairs ;
for my $pos (0..(length $str) - 1 ) {
   push @pairs , [$numbers[ $pos ] , substr( $str , $pos , 1 ) ] ;
}
my @sorted = sort { $a->[0] <=> $b->[0] } @pairs ;
my @letters = map { $_->[1] } @sorted ;
say join( '' , @letters ) ;

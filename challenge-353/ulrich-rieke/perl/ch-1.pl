#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

say "Enter some sentences , <return> to end!" ;
my @sentences ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ) {
    push(@sentences , $line ) ;
    $line = <STDIN> ;
    chomp $line ;
}
my @lengths ;
for my $string( @sentences ) {
    my @words = split( /\s/ , $string ) ;
    push( @lengths , scalar( @words )) ;
}
say max( @lengths ) ;


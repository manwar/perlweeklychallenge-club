#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw( all ) ;

say "Enter some numbers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @sorted = sort { $a <=> $b } @numbers ;
my @differences ;
for my $i (1..scalar( @sorted ) - 1 ) {
    push( @differences , $sorted[$i] - $sorted[$i - 1] ) ;
}
if ( all { $_ == $differences[0] } @differences ) {
    say "true" ;
}
else {
    say "false" ;
}

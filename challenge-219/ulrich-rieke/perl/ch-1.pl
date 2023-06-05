#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some numbers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @sorted = sort { $a <=> $b } map { $_ ** 2 } @numbers ;
say "(" . join( ',' , @sorted ) . ")" ;

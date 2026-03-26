#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a sentence with some words!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
say scalar( grep { substr( $word , 0 , length( $_ )) eq $_ } @words ) ;

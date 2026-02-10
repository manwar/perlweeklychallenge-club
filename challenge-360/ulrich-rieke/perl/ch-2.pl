#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a sentence!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s+/ , $line ) ;
my @sorted = sort { lc( $a ) cmp lc( $b ) } @words ;
say join( ' ' , @sorted ) ;

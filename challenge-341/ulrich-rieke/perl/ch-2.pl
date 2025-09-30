#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word and a letter from this word!" ;
my $line = <STDIN> ;
chomp $line ;
my ($search_in , $search_for) = split( /\s/ , $line ) ;
my $pos = index($search_in , $search_for) ;
my $firstPart = join( '' , reverse split( // , substr( $search_in , 0 , $pos + 1))) ;
my $secondPart = substr( $search_in , $pos + 1 ) ;
say $firstPart . $secondPart ;

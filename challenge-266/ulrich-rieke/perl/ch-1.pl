#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some words, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @firstWords = split( /\s+/ , $line ) ;
say "Enter some more words, separated by blanks!" ;
$line = <STDIN> ;
chomp $line ;
my @secondWords = split( /\s+/ , $line ) ;
my %frequencies ;
map { $frequencies{$_}++ } @firstWords ;
map { $frequencies{$_}++ } @secondWords ;
my @rareWords = grep { $frequencies{$_} == 1 } keys %frequencies ;
if ( @rareWords ) {
   print "(" ;
   say join( ',' ,  @rareWords ) . ')' ;
}
else {
   say "( )" ;
}

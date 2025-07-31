#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
my %frequencies ;
map { $frequencies{$_}++ } split( // , $word ) ;
if ( all { $_ % 2 == 1 } values %frequencies ) {
   say "true" ;
}
else {
   say "false" ;
}

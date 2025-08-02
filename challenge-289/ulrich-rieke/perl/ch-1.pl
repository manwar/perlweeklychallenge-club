#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my %frequencies ;
map { $frequencies{$_}++ } @numbers ;
my @uniques = keys %frequencies ;
my $len = scalar( @uniques ) ;
if ( $len < 3 ) {
   say max( @uniques ) ;
}
else {
   my @sorted = sort {$b <=> $a} @uniques ;
   say $sorted[2] ;
}

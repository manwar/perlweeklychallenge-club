#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some words!" ;
my $line = <STDIN> ;
chomp $line ;
my @firstwords = split( /\s/ , $line ) ;
say "Enter some more words!" ;
$line = <STDIN> ;
chomp $line ;
my @secondwords = split( /\s/ , $line ) ;
my %frequencies ;
for my $w( @firstwords ) {
   $frequencies{$w}++ ;
}
for my $w( @secondwords ) {
   $frequencies{$w}++ ;
}
my @selected = grep { $frequencies{$_} == 1 } keys %frequencies ;
say '(' . join( ',' , @selected ) . ')' ;

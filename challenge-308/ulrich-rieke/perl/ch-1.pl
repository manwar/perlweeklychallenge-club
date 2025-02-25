#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some words separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @firstWords = split( /\s/ , $line ) ;
say "Enter some more words separated by whitespace!" ;
$line = <STDIN> ;
chomp $line ;
my @secondWords = split( /\s/ , $line ) ;
my %firstHash ;
map { $firstHash{$_}++ } @firstWords ;
my %secondHash ;
map { $secondHash{$_}++ } @secondWords ;
my $common = 0 ;
for my $word ( keys %firstHash ) {
   if ( exists( $secondHash{ $word } ) ) {
      $common++ ;
   }
}
say $common ;

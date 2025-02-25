#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some words, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
say "Enter a sentence!" ;
my $sentence = <STDIN> ;
chomp $sentence ;
my @sentencewords = split( /\s/ , $sentence ) ;
my $changedsentence ;
for my $s( @sentencewords ) {
   my $changed = 0 ;
   for my $w ( @words ) {
      if ( $s =~ /^$w/ ) {
	 $changedsentence .= $w ;
	 $changed = 1 ;
      }
   }
   unless ( $changed ) {
      $changedsentence .= $s ;
   }
   $changedsentence .= " " ;
}
say $changedsentence ;

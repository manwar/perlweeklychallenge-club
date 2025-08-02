#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( shuffle ) ;

say "Enter some strings , <return> to end!" ;
my @strings ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ) {
   push( @strings , $line ) ;
   $line = <STDIN> ;
   chomp $line ;
}
my @shuffled ;
for my $inputline( @strings ) {
   my @changed_words ;
   my @words = split( /\s/ , $inputline ) ;
   for my $word( @words ) {
      if ( length $word <= 3 ) {
	 push( @changed_words , $word ) ;
      }
      else {
	 my @letters = split( // , $word ) ;
	 my $changed = $letters[0] ;
	 my @shuffledLetters = shuffle (@letters[1..(length( $word ) - 2)]) ;
	 $changed .= (join( '' , @shuffledLetters) . $letters[$#letters] ) ;
	 push( @changed_words, $changed ) ;
      }
   }
   push( @shuffled, join( ' ' , @changed_words ) ) ;
}
map { say } @shuffled ;

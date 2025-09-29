#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub condition {
   my $word = shift ;
   my $forbidden = shift ;
   for my $letter( split(// , $word ) ) {
      if ( exists( $forbidden->{$letter} ) ) {
	 return 0 ;
      }
   }
   return 1 ;
}

say "Enter a sentence with English letters only!" ;
my $sentence = <STDIN> ;
chomp $sentence ;
my @words = split( /\s/ , $sentence ) ;
say "Enter some letters separated by whitespace!" ;
my $letterline = <STDIN> ;
chomp $letterline ;
my @letters = split( // , $letterline ) ;
my %notWanted ;
map { $notWanted{$_}++ } @letters ;
say scalar( grep { condition( $_, \%notWanted ) } @words ) ;

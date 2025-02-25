#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#look for the position of every letter in the new alphabet ;
#translate that into a word in the conventional alphabet
sub translate {
   my $word = shift ;
   my $alphabet = shift ;
   my $translated ;
   my $concatenated = join( '' , @$alphabet ) ;
   for my $i( 0..length( $word ) - 1 ) {
      my $pos = index( $concatenated , substr( $word , $i , 1 ) ) ;
      $translated .= chr( $pos + 97 ) ;#the corresponding character in the
#normal alphabet 
   }
   return $translated ;
}

say "Enter some strings separated by spaces!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s+/ , $line ) ;
say "Enter a complete alphabet!" ;
$line = <STDIN> ;
chomp $line ;
my @letters = split( /\s+/ , $line ) ;
my %translation ; #maps every word that was input to a translation in the
#ordinary alphabet
map { $translation{$_} = translate( $_ , \@letters ) } @words ;
my @sorted = sort { $translation{$a} cmp $translation{$b} } keys
%translation ;
say '(' . join( ',' , @sorted ) . ')' ;
	 


#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub is_sorted {
  my $word = shift ;
  my $sorted = join( '' , sort split( // , $word )) ;
  return $sorted eq $word ;
}

say "Enter some words, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
say scalar( grep { not ( is_sorted( $_ ) ) } @words ) ;

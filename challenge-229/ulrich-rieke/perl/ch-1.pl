#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub isSorted {
   my $word = shift ;
   my $compare = $word ;
   return ( $compare eq join( '' , sort { $a cmp $b } split( // , $word ) ) ||
	 $compare eq join( '' , sort { $b cmp $a } split( // , $word ) ) ) ;
}

say "Please enter some words, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
say scalar( grep { not isSorted( $_ ) } split ( /\s/ , $line ) ) ;

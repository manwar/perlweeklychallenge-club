#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations ) ;

say "Enter a word, preferably in capital letters only!" ;
my $word = <STDIN> ;
chomp $word ;
my %permuHash ;
my @letters = split( // , $word ) ;
my $iter = permutations( \@letters ) ;
while ( my $p = $iter->next ) {
   $permuHash{ join( '' , @$p ) }++ ;
}
my @sorted = sort keys %permuHash ;
my $pos = 0 ;
do {
   $pos++ ;
} while ( $sorted[ $pos - 1] ne $word ) ;
say $pos ;

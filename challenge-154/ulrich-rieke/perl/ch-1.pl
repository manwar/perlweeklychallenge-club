#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw( permutations ) ;

my @perlPermutations = ( "PELR", "PREL", "PERL", "PRLE", "PLER", "PLRE",
      "EPRL", "EPLR", "ERPL", "ERLP", "ELPR", "ELRP", "RPEL", "RPLE",
      "REPL", "RELP", "RLPE", "RLEP", "LPER", "LPRE", "LEPR",
      "LRPE", "LREP" )  ;
my %firstPermutations ;
map { $firstPermutations{ $_ }++ } @perlPermutations ;
my @letters = split( // , "PERL" ) ;
my %secondPermutations ;
my $iter = permutations( \@letters ) ;
while ( my $c = $iter->next ) {
  $secondPermutations{join( '' , @$c )}++ ;
}
say grep { not exists( $firstPermutations{ $_ } ) } keys %secondPermutations ;

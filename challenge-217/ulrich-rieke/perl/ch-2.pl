#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations ) ;

sub concatenate {
  my $numbers = shift ;
  my $concatenated ;
  for my $num ( @{$numbers} ) {
      $concatenated .= $num ;
  }
  return $concatenated ;
}

say "Enter some numbers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $iter = permutations( \@numbers ) ;
my @results ;
while ( my $c = $iter->next ) {
  push @results , concatenate( $c ) ;
}
my @sorted = sort { $b <=> $a } @results ;
say $sorted[ 0 ] ;

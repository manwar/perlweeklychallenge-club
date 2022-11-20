#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations ) ;
use List::Util qw ( all ) ;

sub createPairs {
  my $array = shift ;
  my @pairs ;
  my $num = 1 ;
  for my $i ( @$array ) {
      push @pairs , [ $num , $i ] ;
      $num++ ;
  }
  return @pairs ;
}

sub isCute {
  my $pairarray = shift ;
  return all { ($_->[0] % $_->[1] == 0) || ($_->[1] % $_->[0] == 0) }
    @$pairarray ;
}

say "Enter a number greater than 0 and up to and including 15!" ;
my $n = <STDIN> ;
chomp $n ;
my @array = (1 .. $n ) ;
my $count = 0 ;
my $iter = permutations( \@array ) ;
while ( my $p = $iter->next ) {
  my @currentPairs = createPairs( $p ) ;
  if ( isCute( \@currentPairs ) ) {
      $count++ ;
  }
}
say $count ;

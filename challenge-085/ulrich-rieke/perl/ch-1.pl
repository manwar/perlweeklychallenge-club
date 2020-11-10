#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw( combinations ) ;
use List::Util qw( sum ) ;

sub enterArray {
  my @numbers ;
  say "Enter at least 3 non-negative real numbers ( -1 to end )!" ;
  my $num = <STDIN> ;
  chomp $num ;
  while ( $num != -1 ) {
      push @numbers , $num ;
      $num = <STDIN> ;
      chomp $num ;
  }
  return @numbers ;
}

my @array = enterArray( ) ;
my $triplets = 0 ;
my $iter = combinations( \@array , 3 ) ;
while ( my $p = $iter->next ) {
  my $sum = sum @$p ;
  if ( $sum > 1 and $sum < 2 ) {
      $triplets = 1 ;
      last ;
  }
}
say $triplets ;

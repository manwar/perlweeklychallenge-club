#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw( combinations ) ;
use List::Util qw ( any ) ;

my $output = 0 ;
my $n = $ARGV[ 0 ] ;
while ( $n !~ /\d+/ ) {
  say "The number entered should be an integer!\n" ;
  $n = <STDIN> ;
  chomp $n ;
}
my @divisors ;
for my $i ( 1 .. $n ) {
  if ( $n % $i == 0 ) {
      push @divisors , $i ;
  }
}
my @combis_of_two ;
my $iter = combinations(\@divisors , 2 ) ;
while ( my $c = $iter->next ) {
  push @combis_of_two, $c ;
}
if ( scalar( @combis_of_two ) > 1 ) {
  my @possible_pairs = grep { $_->[0] * $_->[1] == $n } @combis_of_two ;
  my $root = sqrt( $n ) ;
  if ( $root == int( $root )) {
      my @array = ( $root , $root ) ;
      push @possible_pairs , \@array ;
  }
  if ( scalar( @possible_pairs ) > 1) {
      my %checked ;
      my $nextOne = shift @possible_pairs ;
      $checked{ join( '|' , @$nextOne ) }++ ;
      LOOP: while ( $checked{ join ( '|' , @$nextOne ) } < 2 ) {
    if ( any { $nextOne->[0] + $nextOne->[1] == ($_->[0] + $_->[1] + 1) }
          @possible_pairs ) {
        $output = 1 ;
        last LOOP ;
    }
    else {
        push @possible_pairs , $nextOne ;
        $nextOne = shift @possible_pairs ;
        $checked{ join( '|' , @$nextOne ) }++ ;
    }
      }
  }
  else {
      $output = 0 ;
  }
}
else {
  $output = 0 ;
}
say $output ;

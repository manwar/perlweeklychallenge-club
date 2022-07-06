#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;
use List::Util qw ( sum ) ;
use POSIX ;

sub isPrime {
  my $number = shift ;
  my $stop = sqrt( $number ) ;
  for my $i ( 2 .. floor( $stop )) {
      if ( $number % $i == 0 ) {
        return 0 ;
      }
  }
  return 1 ;
}

say "Enter 2 numbers m and n , separated by blank( m should be greater than n!)!" ;
my $line = <STDIN> ;
chomp $line ;
my ($m , $n ) = split( /\s+/ , $line ) ;
while ( $n > $m ) {
  say "Second number should be smaller than the first one! Re-enter!" ;
  $line = <STDIN> ;
  chomp $line ;
  ($m , $n ) = split( /\s+/ , $line ) ;
}
my @primes ;
for my $i (2 .. $m) {
  if ( isPrime( $i ) ) {
      push @primes , $i ;
  }
}
my $iter = combinations( \@primes , $n ) ;
while ( my $c = $iter->next ) {
  if ( sum( @$c ) == $m ) {
      say join (',' , @$c ) ;
  }
}

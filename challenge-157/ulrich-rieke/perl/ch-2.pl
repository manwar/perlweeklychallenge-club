#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub allSame {
  my $numbers = shift ;
  my %numbercount ;
  for my $num ( @$numbers ) {
      $numbercount{ $num }++ ;
  }
  return (scalar( keys %numbercount ) == 1 ) ;
}

sub toBase {
  my $number = shift ;
  my $base = shift ;
  my @digits ;
  while ( $number != 0 ) {
      push @digits , $number % $base ;
      $number = int( $number / $base ) ;
  }
  return @digits ;
}

my $n = $ARGV[0] ;
while ( $n <= 3 ) {
  say "number should be greater than 3! Re-enter!" ;
  my $line = <STDIN> ;
  chomp $line ;
  $n = $line ;
}
my $isBrazilian = 0 ;
for my $i ( 2 .. $n - 2 ) {
  my @digits = toBase( $n , $i ) ;
  if ( allSame( \@digits ) ) {
      $isBrazilian = 1 ;
      last ;
  }
}
if ( $isBrazilian ) {
  say 1 ;
}
else {
  say 0 ;
}

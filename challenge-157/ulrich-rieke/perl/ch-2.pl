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
  my $extended = shift ;
  my @digits ;
  while ( $number != 0 ) {
      my $remainder = $number % $base ;
      if ( $remainder > 10 ) {
    push @digits , $extended->{$remainder} ;
      }
      else {
    push @digits, $remainder ;
      }
      $number = int( $number / $base ) ;
  }
  return @digits ;
}

my $n = $ARGV[0] ;
#the algorithm allows bases from 2 to 36 and therefore numbers from 3 + 1 to
#36 + 2
while ( $n <= 3 || $n > 38 ) {
  say "number should be greater than 3 and smaller than 39! Re-enter!" ;
  my $line = <STDIN> ;
  chomp $line ;
  $n = $line ;
}
#if the number base is greater than 10 we introduce letters to denote the rest
#of dividing a number by the base
my @letters = ('A' .. 'Z') ;
my @numbers = (11 .. 36 ) ;
my %extendedBases ;
#each number from 11 to 36 corresponds to a letter
for my $num (0 .. 25 ) {
  $extendedBases{ $numbers[$num] } = $letters[$num] ;
}
my $isBrazilian = 0 ;
for my $i ( 2 .. $n - 2 ) {
  my @digits = toBase( $n , $i , \%extendedBases ) ;
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

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use feature 'unicode_strings' ;
use List::Util qw ( min max ) ;
use open ":std", ":encoding(UTF-8)";

sub findOctal {
  my $number = shift ;
  my $octals = shift ;
  my $current = 0 ;
  while ( $octals->[$current] < $number ) {
      $current++ ;
      if ( $current == 8 ) {
    last ;
      }
  }
  if ( $current == 8 ) {
      return 7 ;
  }
  else {
      return $current ;
  }
}

say "Enter some numbers , separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my $maximum = max( @numbers ) ;
my $minimum = min( @numbers ) ;
my $range = $maximum - $minimum ;
#@octals holds the limits of all the octiles , that is from the smallest
#number to the first octile, from the first octile to the second octile and
#so on to the biggest number. We choose octile because we use the
#8 subsequent Unicode codepoints for growing black bars
my @octals ;
push @octals, $minimum ;
for my $i ( 1 .. 7 ) {
  push @octals, $range / 8 * $i ;
}
push @octals, $maximum ;
my @blockCodePoints = ( 0x2581 , 0x2582, 0x2583 , 0x2584 ,
      0x2585 , 0x2586 , 0x2587 , 0x2588) ;
my @octalQuantiles = map { findOctal( $_ , \@octals ) } @numbers ;
for my $octal( @octalQuantiles[0 .. (scalar @octalQuantiles) - 2] ) {
  my $str = chr( $blockCodePoints[ $octal ] ) ;
  print $str ;
}
say chr( $blockCodePoints[ $octalQuantiles[-1]] ) ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub findValley {
  my $array = shift ;
  my $pos = shift ;
  my $currentPos = $pos ;
  my $result ;
  my $len = scalar( @$array ) ;
  do {
      $currentPos++ ;
  } while ( $currentPos <  $len && $array->[$currentPos] <=
    $array->[ $currentPos - 1 ] ) ;
  if ( $currentPos == $len ) {
      $result = [$pos , $currentPos - 1 - $pos] ;
  }
  else {
      do {
    $currentPos++ ;
      } while ( $currentPos <  $len && $array->[$currentPos] >=
        $array->[$currentPos - 1] ) ;
      $result = [ $pos , $currentPos - 1 - $pos ] ;
  }
  return $result ;
}

say "Enter some integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split ( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my @positions ;
for my $i (0..$len - 2 ) {
  my $result = findValley(\@numbers , $i ) ;
  push( @positions, $result ) ;
}
my @sorted = sort { $b->[1] <=> $a->[1] || $a->[0] <=> $b->[0] }
  @positions ;
my $startpos = $sorted[0]->[0] ;
my $stride = $sorted[0]->[1] ;
say join( ", " , @numbers[$startpos..$startpos + $stride] ) ;

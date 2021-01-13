#!/usr/bin/perl ;
use strict ;
use warnings ;
use POSIX qw ( floor ) ;

sub toBinary {
  my $num = shift ;
  my @nums ;
  while ( $num != 0 ) {
      my $remainder = $num % 2 ;
      push @nums, $remainder ;
      $num = floor ( $num / 2 ) ;
  }
  return reverse @nums ;
}

sub countChars {
  my $string = shift ;
  my $searched = shift ;
  return scalar ( grep { $_ eq $searched } split ( // , $string ) ) ;
}

sub myFlip {
  my $string = shift ;
  my $len = length $string ;
  for my $i ( 0..$len - 1) {
      if ( substr( $string , $i , 1 ) eq "1" ) {
    substr( $string , $i , 1 ) = "0" ;
      }
      else {
    substr( $string , $i , 1 ) = "1" ;
      }
  }
  return $string ;
}

my @flippedArrs ;
my @digits = toBinary ( $ARGV[0] ) ;
my $len = scalar @digits ;
my $binary = join ( '' , @digits ) ;
for my $l (0 .. $len - 1 ) {
  for my $r ( $l .. $len - 1 ) {
      my $flipped = substr( $binary , 0 , $l ) .
    myFlip( substr( $binary , $l , $r - $l ) ) .
    substr ( $binary, $r ) ;
      push @flippedArrs, [ $l , $r , countChars( $flipped , "1" ) ] ;
  }
}
my @sorted = sort { ${$b}[2] <=> ${$a}[2] } @flippedArrs ;
print ("L " . $sorted[0][0] . " , R " . $sorted[0][1] . "\n" ) ;
my $i = 1 ;
while ( $sorted[ $i ][ 2 ] == $sorted[ 0 ][ 2 ] ) {
  print ("L " . $sorted[$i][0] . " , R " . $sorted[$i][1] . "\n") ;
  $i++ ;
}

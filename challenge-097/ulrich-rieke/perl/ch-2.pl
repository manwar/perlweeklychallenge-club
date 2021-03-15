#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw( sum ) ;

sub countToMakeAllEqual {
  my $str = shift ;
  my %frequencies ;
  $frequencies{ '0' } = '0' ;
  $frequencies{ '1' } = '0' ;
  my $len = length( $str ) ;
  for my $i ( '0' .. $len - '1' ) {
      $frequencies{ substr( $str , $i , '1' ) }++ ;
  }
  if ( $frequencies{ '0' } == $len or $frequencies{ '1' } == $len ) {
      return '0' ;
  }
  elsif ( $frequencies{ '0' } >= $frequencies{ '1' } ) {
      return $len - $frequencies{ '0' } ;
  }
  else {
      return $len - $frequencies{ '1' } ;
  }
}

my $B = $ARGV[ 0 ] ;
my $S = $ARGV[ 1 ] ;
die "The length of $B should be a multiple of $S" unless ( (length $B) % $S == 0 ) ;
my $len = length( $B ) ;
my $chunknumber = $len / $S ;
my $chunklength = $len / $chunknumber ;
my @chunks ;
for  my $i ( 0 .. $chunknumber - 1 ) {
  push (@chunks , substr( $B, $i * $chunklength , $chunklength ) ) ;
}
my @words ;
for my $i ( 0 .. $chunklength - 1 ) {
  for my $j ( 0 .. $chunknumber - 1 ) {
      $words[ $i ] .= substr( $chunks[ $j ] , $i , 1 ) ;
  }
}
say sum map { countToMakeAllEqual( $_ ) } @words ;

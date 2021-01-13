#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub enterArray {
  my @array ;
  print "Enter a number ( end to end ) :\n" ;
  my $number = <STDIN> ;
  chomp $number ;
  while ( $number ne "end" ) {
      if ( $number =~ /\d+/ ) {
    push( @array, $number ) ;
      }
      print "Enter a number ( end to end ) :\n" ;
      $number = <STDIN> ;
      chomp $number ;
  }
  return @array ;
}

my @array = enterArray( ) ;
my %frequencies ;
my $len = scalar @array ;
while ( @array ) {
  $frequencies{ shift @array }++ ;
}
my @sorted = sort { $frequencies{ $b } <=> $frequencies{ $a } } keys
%frequencies ;
if ( $frequencies{ $sorted[ 0 ] } > int( $len / 2 ) ) {
  say $sorted[ 0 ] ;
}
else {
  say -1 ;
}

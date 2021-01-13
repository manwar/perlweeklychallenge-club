#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub enterArray {
  my @numbers ;
  print "Enter a number ( end to end ) :\n" ;
  my $number = <STDIN> ;
  chomp $number ;
  while ( $number ne "end" ) {
      if ( $number =~ /\d+/ ) {
    push (@numbers , $number ) ;
      }
      print "Enter a number ( end to end ) :\n" ;
      $number = <STDIN> ;
      chomp $number ;
  }
  return @numbers ;
}

sub leftRotate {
  my $array = shift ;
  my $rotateBy = shift ;
  my $len = scalar @$array ;
  my @rotated ;
  if ( $rotateBy > $len - 1 ) {
      return 0 ; #invalid operation, index too great
  }
  else {
      my @subarray = @$array[$rotateBy .. $len - 1] ;
      push( @rotated , @subarray ) ;
      @subarray = @$array[0 .. $rotateBy - 1] ;
      push( @rotated , @subarray ) ;
      return @rotated ;
  }
}

my @array = enterArray( ) ;
my @indices = enterArray( ) ;
for my $index ( @indices ) {
  my @rotated = leftRotate( \@array , $index ) ;
  my $line = '(' . join( " " , @rotated ) . ')' ;
  say $line ;
}

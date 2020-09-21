#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub findMaximum {
  my $array = shift ;
  my $maximum = shift @$array ;
  while ( @$array ) {
      my $el = shift @$array ;
      if ( $el > $maximum ) {
    $maximum = $el ;
      }
  }
  return $maximum ;
}

sub enterArray {
  my @numbers ;
  my %seen ; #to ensure uniqueness of every number
  print "Enter a number ( end to end ) :\n" ;
  my $number = <STDIN> ;
  chomp $number ;
  while ( $number ne "end" ) {
      if ( $number =~ /\d+/ && not exists $seen{ $number }) {
    push( @numbers, $number ) ;
    $seen{ $number }++ ;
      }
      print "Enter a number ( end to end ) :\n" ;
      $number = <STDIN> ;
      chomp $number ;
  }
  return @numbers ;
}

my @array = enterArray( ) ;
my @leaders ;
my $len = scalar @array ;
for my $i (0 .. $len - 2 ) {
  my @subarray = @array[$i + 1 .. $len - 1] ;
  my $localmax = findMaximum( \@subarray) ;
  if ( $array[ $i ] > $localmax) {
      push( @leaders, $array[ $i ] ) ;
  }
}
push (@leaders, $array[-1] ) ;
my $line = '(' . join( " , " , @leaders ) . ')' ;
say $line ;

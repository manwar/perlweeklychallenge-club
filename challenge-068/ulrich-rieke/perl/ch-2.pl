#!/usr/bin/perl ;
use strict ;
use warnings ;

sub enterArray {
  my @array ;
  print "Enter an array element ( end to end ): " ;
  my $element = <STDIN> ;
  chomp $element ;
  while ( $element ne "end" ) {
      push( @array , $element ) ;
      print "Enter an array element ( end to end ): " ;
      $element = <STDIN> ;
      chomp $element ;
  }
  return @array ;
}

sub mergeArrays {
  my $firstarray = shift ;
  my $secondarray = shift ;
  my @merged ;
  for (0..scalar @$firstarray + scalar @$secondarray - 1 ) {
      if ( @$firstarray ) {
    push( @merged, shift @$firstarray ) ;
      }
      if ( @$secondarray ) {
    push ( @merged , shift @$secondarray ) ;
      }
  }
  return @merged ;
}

my @array = enterArray( ) ;
my @original = @array ;
my $len = scalar @array ;
my $half = int( $len / 2 ) ;
my @firstpart = @array[0..$half - 1] ;
my @reversed = reverse @array[$half..$len - 1] ;
my @merged = mergeArrays( \@firstpart , \@reversed ) ;
print "Original:\n" ;
print join ("->" , @original ) . "\n" ;
print "reordered:\n" ;
print join( "->" , @merged ) . "\n" ;


#!/usr/bin/perl ;
use strict ;
use warnings ;

sub enterList {
  my @input ;
  print "Enter next number ( 'e' to end! ) : " ;
  my $number = <STDIN> ;
  chomp $number ;
  while ( $number ne 'e' ) {
      push( @input , $number ) ;
      print "Enter next number ( 'e' to end! ) : " ;
      $number = <STDIN> ;
      chomp $number ;
  }
  return @input ;
}

sub findSublists {
  my $array = shift ;
  my $len = scalar (@{$array}) - 1 ;
  my @sublists ;
  for my $start (0..$len - 1 ) {
      for my $end ( $start + 1 ..$len ) {
    my @sublist = @{$array}[$start..$end] ;
    push( @sublists, \@sublist ) ;
      }
  }
  return @sublists ;
}

my @input = enterList( ) ;
my @sublists = findSublists( \@input ) ;
my %producthash ;
for my $sublist ( @sublists ) {
  my $product = 1 ;
  for my $element ( @{$sublist} ) {
      $product *= $element ;
  }
  $producthash{ $product } = $sublist ;
}
my @sorted = sort { $b <=> $a } keys %producthash ;
my $biggest_product = $sorted[ 0 ] ;
print "The biggest product ( $biggest_product ) is produced by " ;
print "[ " ;
print join( ', ' , @{$producthash{ $biggest_product }} ) ;
print " ]!\n" ;

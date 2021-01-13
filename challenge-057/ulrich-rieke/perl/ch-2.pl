#!/usr/bin/perl ;
use strict ;
use warnings ;

sub findDifference {
  my $word1 = shift ;
  my $word2 = shift ;
  my $i = 0 ;
  while ( substr( $word1 , $i , 1 ) eq substr( $word2 , $i , 1 ) ) {
      $i++ ;
  }
  return $i ;
}

#create of hash, with the words as a key and the array of numbers of common
#starting sequences of their immediate neighbours in the sorted array
#as value. The maximum value of this array + 1 represents the unique
#sequence

my @words = ("alphabet" , "book" , "carpet" , "cadmium" , "cadeau" ,
      "alpine" ) ;
my @sorted = sort @words ;
my %prefixes ;
my $len = $#words ;
foreach my $i ( 0..$len - 1) {
  my $commonlen = findDifference( $sorted[ $i ] , $sorted[ $i + 1 ] ) ;
  push ( @{$prefixes{ $sorted[ $i ] }} , $commonlen ) ;
  push ( @{$prefixes{ $sorted[ $i + 1 ] }} , $commonlen ) ;
}
print "[ " ;
foreach my $i (0..$len) {
  my @commonsorted = sort { $b <=> $a } @{$prefixes{ $words[ $i ] }} ;
  my $max = $commonsorted[ 0 ] ;
  print substr( $words[ $i ] , 0 , $max + 1 ) ;
  if ( $i != $len ) {
      print " , " ;
  }
}
print " ]\n" ;

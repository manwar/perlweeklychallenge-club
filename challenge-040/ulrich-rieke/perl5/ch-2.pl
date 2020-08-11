#!/usr/bin/perl
use strict ;
use warnings ;

my @list = ( 10, 4, 1, 8, 12, 3 ) ;
my @indices = ( 0, 2, 5 ) ;
#a numerical comparison is to be enforced in the next 2 lines
my @sortedSlice = sort { $a <=> $b } @list[@indices] ;
my @sortedIndices = sort { $a <=> $b } @indices ;
my $arraylen = @sortedIndices + 0 ;
for ( my $i = 0 ; $i < $arraylen ; $i++ ) {
  $list[ $sortedIndices[ $i ]] = $sortedSlice[ $i ] ;
}
for my $item ( @list ) {
  print "$item " ;
}
print "\n" ;

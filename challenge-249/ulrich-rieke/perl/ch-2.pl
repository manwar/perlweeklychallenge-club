#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations ) ;

sub isValid {
   my $permutation = shift ;
   my $ipositions = shift ;
   my $dpositions = shift ;
   for my $pos ( @$ipositions ) {
      if ( $permutation->[$pos] >= $permutation->[ $pos + 1 ] ) {
	 return 0 ;
      }
   }
   for my $pos ( @$dpositions ) {
      if ( $permutation->[$pos] <= $permutation->[ $pos + 1 ]) {
	 return 0 ;
      }
   }
   return 1 ;
}

say "Enter a string consisting of capital I and D only!" ;
my $line = <STDIN> ;
chomp $line ;
my @is ;
my @ds ;
my $len = length $line ;
for my $pos( 0..$len - 1 ) {
   if ( substr( $line, $pos , 1 ) eq "I" ) {
      push @is , $pos ;
   }
   else {
      push @ds, $pos ;
   }
}
my @positions = (0..$len) ;
my $iter = permutations( \@positions ) ;
while ( my $c = $iter->next ) {
   if ( isValid( $c , \@is , \@ds ) ) {
      say ( "(" . join( ',' , @$c ) . ")" ) ;
      last ;
   }
}

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub isSimilar {
   my $first = shift ;
   my $second = shift ;
   if (( $first->[0] == $second->[0] && $first->[1] == $second->[1] ) || 
      ($first->[0] == $second->[1] && $first->[1] == $second->[0] )) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

say "Enter 2 integers to denote a domino! Separate by blanks!" ;
say "To end entry, enter <return>!" ;
my @dominoes ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ) {
   my @numbers = split( /\s/ , $line ) ;
   push( @dominoes, \@numbers ) ;
   $line = <STDIN> ;
   chomp $line ;
}
my $len = scalar( @dominoes ) ;
my %indices ;
for my $i (0..$len - 2 ) {
   for my $j ($i + 1 .. $len - 1 ) {
      if ( isSimilar( $dominoes[$i] , $dominoes[$j]) == 1 ) {
	 $indices{$i}++ ;
	 $indices{$j}++ ;
      }
   }
}
say scalar( keys( %indices ) ) ;


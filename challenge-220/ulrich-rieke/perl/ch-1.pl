#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some words, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my @allLower = map { lc $_ } @words ;
my $len = scalar( @words ) ;
my %lettercount ;
for my $letter ( split( // , $allLower[ 0 ] ) ) {
  $lettercount{$letter}++ ;
}
if ( $len == 1 ) {
  say "(" . join( ',' , sort { $a cmp $b } keys %lettercount ) . ")" ;
}
else {
  my @old_intersection = keys %lettercount ;
  for my $i ( 1..$len - 1 ) {
      my @new_intersection ;
      for my $letter ( @old_intersection ) {
    if ( index( $allLower[ $i ] , $letter ) > -1 ) {
        push @new_intersection , $letter ;
    }
      }
      @old_intersection = @new_intersection ;
  }
  say "(" . join( ',' , sort { $a cmp $b } @old_intersection ) . ")" ;
}

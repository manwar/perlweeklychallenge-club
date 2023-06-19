#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw( subsets ) ;

sub is_arithmetic {
  my $array = shift ;
  my $len = scalar( @$array ) ;
  my $start = $array->[1] - $array->[0] ;
  for my $i ( 1..$len - 2 ) {
      if ( $array->[ $i + 1 ] - $array->[$i] != $start ) {
    return 0 ;
      }
  }
  return 1 ;
}

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar ( @numbers ) ;
my $iter = subsets( \@numbers ) ;
my $maxlen = 0 ;
while ( my $c = $iter->next ) {
  my $sublen = scalar( @$c ) ;
  if ( $sublen > 1 ) {
      if ( is_arithmetic( $c ) ) {
    if ( $sublen > $maxlen ) {
        $maxlen = $sublen ;
    }
      }
  }
}
say $maxlen ;

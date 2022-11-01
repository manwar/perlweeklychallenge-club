#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max min sum ) ;

sub findDegree {
  my $array = shift ;
  my %frequencies ;
  for my $elem ( @$array ) {
      $frequencies{ $elem }++ ;
  }
  return max( values %frequencies ) ;
}

say "Enter a number of positive integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $degree = findDegree( \@numbers ) ;
if ( $degree == 1 ) {
  say min( @numbers ) ;
}
else {
  my @subarrays ;
  my $arraylen = scalar( @numbers ) ;
  for my $stepwidth( $degree .. $arraylen ) {
      for my $start( 0..$arraylen - $stepwidth ) {
    my @subarray ;
    for my $pos( 0..$stepwidth - 1 ) {
        push( @subarray, $numbers[ $start + $pos ] ) ;
    }
    if ( findDegree( \@subarray ) == $degree ) {
        push @subarrays , \@subarray ;
    }
      }
  }
  my @sortedArray = sort { sum( @$a ) <=> sum( @$b ) } @subarrays ;
  say join( ',' , @{$sortedArray[0]} ) ;
}

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

say "Enter a string consisting of 0 and 1 only!" ;
my $word = <STDIN> ;
chomp $word ;
my $len = length( $word ) ;
my @subsums ;
for my $pos( 1..$len - 1 ) {
   my @left = split( // , substr( $word , 0 , $pos )) ;
   my @right = split( // , substr( $word , $pos )) ;
   my $zeroes = scalar( grep { $_ eq '0' } @left ) ;
   my $ones = scalar( grep { $_ eq '1' } @right ) ;
   push( @subsums , $zeroes + $ones ) ;
}
say max( @subsums ) ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum  min ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
say "Enter a number less than or equal to the length of the array above!" ;
my $n = <STDIN> ;
chomp $n ;
my $len = scalar( @numbers ) ;
my $maxi = min( @numbers ) ;
for my $start( 0..$len - $n ) {
   my $subsum = sum( @numbers[$start..$start + $n - 1] ) ;
   my $avg = $subsum / $n ;
   if ( $avg > $maxi ) {
      $maxi = $avg ;
   }
}
say $maxi ;


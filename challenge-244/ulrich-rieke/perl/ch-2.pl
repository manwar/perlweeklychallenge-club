#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;
use List::Util qw ( max min ) ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my $sum = 0 ;
for my $n ( @numbers ) {
   $sum += $n ** 2 * $n ;
}
for my $l ( 2..$len ) {
   my $iter = combinations( \@numbers , $l ) ;
   while ( my $c = $iter->next ) {
      my $maximum = max( @$c ) ;
      my $minimum = min( @$c ) ;
      $sum += $maximum ** 2 * $minimum ;
   }
}
say $sum ;


#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max min ) ;

sub position {
   my $array = shift ;
   my $elt = shift ;
   my $pos = 0 ;
   while ( $array->[$pos] != $elt ) {
      $pos++ ;
   }
   return $pos ;
}

say "Enter some unique integers!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $mini = min( @numbers ) ;
my $maxi = max( @numbers ) ;
my $minpos = position( \@numbers , $mini ) ;
my $maxpos = position( \@numbers , $maxi ) ;
my $len = scalar( @numbers ) ;
if ( $minpos < $maxpos ) {
   say ( $minpos + $len - 1 - $maxpos ) ;
}
else {
   say ( $minpos + $len - 1 - $maxpos - 1 ) ;
}


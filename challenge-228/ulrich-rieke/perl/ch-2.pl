#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min ) ;

sub findIndex {
   my $array = shift ;
   my $needle = shift ;
   my $pos = 0 ;
   while ( $array->[$pos] != $needle ) {
      $pos++ ;
   }
   return $pos ;
}

say "Enter some unique integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $rounds = 0 ;
while ( scalar( @numbers ) > 0 ) {
   my $mini = min( @numbers ) ;
   my $pos = findIndex( \@numbers , $mini ) ;
   my $num = shift @numbers ;
   if ( $pos == 0 ) {
   }
   else {
      push @numbers , $num ;
   }
   $rounds++ ;
}
say $rounds ;


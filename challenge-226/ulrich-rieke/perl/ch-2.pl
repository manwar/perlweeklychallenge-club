#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all min ) ;

sub mySubtr {
   my $num = shift ;
   my $mini = shift ;
   $num -= $mini ;
   if ( $num < 0 ) {
      $num = 0 ;
   }
   return $num ;
}

say "Enter some positive integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $rounds = 0 ;
while ( not ( all { $_ == 0 } @numbers ) ) {
   my $mini = min grep { $_ > 0 } @numbers ;
   $rounds++ ;
   @numbers = map { mySubtr( $_ , $mini ) } @numbers ;
}
say $rounds ;

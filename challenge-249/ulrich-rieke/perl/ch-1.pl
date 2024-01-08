#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

say "Enter an even number of integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my %frequencies ;
my @numbers = split( /\s+/ , $line ) ;
for my $num ( @numbers ) {
   $frequencies{ $num }++ ;
}
if ( all { $_ % 2 == 0 } values %frequencies ) {
   my @sorted = sort { $a <=> $b } @numbers ;
   my $len = scalar( @numbers ) ;
   my @result ;
   my $pos = 0 ;
   while ( $pos <= $len - 2 ) {
      my $pair = [$sorted[ $pos ] , $sorted[ $pos + 1 ]] ;
      push @result, $pair ;
      $pos += 2 ;
   }
   print "(" ;
   for my $pair( @result ) {
      print ( "(" . join( ',' , @$pair ) . ")" ) ;
   }
   say ")" ;
}
else {
   say "()" ;
}

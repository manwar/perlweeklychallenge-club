#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

say "Enter some 0 and 1 , enter <enter> to end!" ;
my @matrix ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ) {
   my @row = split( /\s/ , $line ) ;
   push( @matrix , \@row ) ;
   $line = <STDIN> ;
   chomp $line ;
}
my $result ;
my @selected = grep { all { $_ == 0 } @{$_} } @matrix ;
if ( scalar( @selected ) != 1 ) {
   $result = -1 ;
}
else {
   my $pos = 0 ;
   while ( not ( all { $_ == 0 } @{$matrix[$pos]} ) ) {
      $pos++ ;
   }
   for my $row (0..scalar( @matrix ) - 1) {
      if ( $row != $pos && $matrix[$row]->[$pos] != 1 ) {
         $result = -1 ;
         last ;
      }
      $result = $pos ;
   }
}
say $result ;

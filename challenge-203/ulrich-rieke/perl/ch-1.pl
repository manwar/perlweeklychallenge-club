#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;

say "Please enter at least 4 integers , separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $specials = 0 ;
if ( scalar ( @numbers ) >= 4 ) {
  my $iter = combinations( \@numbers , 4 ) ;
  while ( my $p = $iter->next ) {
      if ( $p->[0] + $p->[1] + $p->[2] == $p->[3] ) {
    $specials++ ;
      }
  }
  say $specials ;
}
else {
  say "Enter at least 4 integers!" ;
}

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @nonzeroes = grep { $_ != 0 } @numbers ;
my @zeroes = grep { $_ == 0 } @numbers ;
if ( @zeroes ) {
  for (1..scalar( @zeroes ) ) {
      push @nonzeroes , 0 ;
  }
  say '(' . join( ',' , @nonzeroes ) . ')' ;
}
else {
  say '(' . join ( ',' , @numbers ) . ')' ;
}

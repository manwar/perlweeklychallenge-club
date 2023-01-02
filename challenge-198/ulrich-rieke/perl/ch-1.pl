#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

say "Please enter some integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
if ( scalar( @numbers ) < 2 ) {
  say 0 ;
}
else {
  my @sorted = sort { $a <=> $b } @numbers ;
  my @differences ;
  my $len = scalar( @sorted ) ;
  for my $i ( 0..$len - 2 ) {
      push ( @differences , $sorted[ $i + 1 ] - $sorted[ $i ] ) ;
  }
  my $maxdiff = max (@differences) ;
  say scalar( grep { $_ == $maxdiff } @differences ) ;
}

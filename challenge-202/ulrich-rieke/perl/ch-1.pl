#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

say "Please enter at least 3 integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
while ( scalar( @numbers ) < 3 ) {
  say "Enter at least 3 integers, separated by a blank!" ;
  $line = <STDIN> ;
  chomp $line ;
  @numbers = split ( /\s/ , $line ) ;
}
my $len = scalar( @numbers ) ;
my $result = 0 ;
for my $i (0..$len - 3 ) {
  if ( all { $_ % 2 == 1 } @numbers[$i..$i + 2] ) {
      $result = 1 ;
      last ;
  }
}
say $result ;

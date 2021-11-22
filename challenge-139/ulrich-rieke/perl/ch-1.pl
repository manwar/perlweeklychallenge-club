#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Please enter a line of numbers, separated by a blank and a blank at the end!" ;
my $line = <STDIN> ;
chomp $line ;
while ( $line !~ /\A\s*(\d+\s)+\z/ ) {
  say "numbers should be separated by a blank , blank at the end!" ;
  $line = <STDIN> ;
  chomp $line ;
}
my @numbers = split( /\s/ , $line ) ;
my @sorted = sort { $a <=> $b } @numbers ;
if ( join( '' , @sorted ) eq join( '' , @numbers ) ) {
  say "1" ;
}
else {
  say "0" ;
}

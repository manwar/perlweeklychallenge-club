#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max any ) ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $maximum = max( @numbers ) ;
if ( any { ($_ != $maximum) && ($maximum < 2 * $_) } @numbers ) {
  say -1 ;
}
else {
  say 1 ;
}

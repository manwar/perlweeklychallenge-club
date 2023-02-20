#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

say "Enter some integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @differences ;
my $len = scalar( @numbers ) ;
for my $i ( 0..$len - 2 ) {
  push @differences , $numbers[ $i + 1 ] - $numbers[ $i ] ;
}
if (( all { $_ <= 0 } @differences) || (all { $_ >= 0 } @differences )) {
  say 1 ;
}
else {
  say 0 ;
}

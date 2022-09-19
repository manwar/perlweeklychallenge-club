#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
while ( $line !~ /\A(\d+\s*)+\z/ ) {
  say "Enter some integers and separate them with a blank!" ;
  $line = <STDIN> ;
  chomp $line ;
}
my @numbers = split( /\s+/ , $line ) ;
say "Enter an integer! " ;
$line = <STDIN> ;
chomp $line ;
say ( '(' . join( "," , grep { $_ > $line } @numbers ) . ')' ) ;

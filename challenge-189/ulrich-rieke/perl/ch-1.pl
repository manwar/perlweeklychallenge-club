#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a number of characters, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @characters = split( /\s/ , $line ) ;
say "Enter a target character!" ;
my $target = <STDIN> ;
chomp $target ;
my @sorted = sort @characters ;
my $current = 0 ;
while ( not ( $sorted[ $current ]  gt $target) ) {
  $current++ ;
}
say $sorted[ $current ] ;

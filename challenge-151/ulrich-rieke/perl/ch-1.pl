#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a tree , separate levels by a |" ;
my $tree = <STDIN> ;
chomp $tree ;
my $len = length $tree ;
my $mindepth = 0 ;
for my $pos (0 .. $len - 1 ) {
  if ( substr( $tree , $pos , 1 ) eq '|' ) {
      $mindepth++ ;
  }
}
say $mindepth ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
my $result ;
my $howmany = 0 ;
for my $letter( split( // , $word ) ) {
   for (0..$howmany) {
      $result .= $letter ;
   }
   $howmany++ ;
}
say $result ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
my @numbers = map { ord $_ } split( // , $word ) ;
my $len = scalar( @numbers ) ;
my $sum = 0 ;
for my $pos( 0..$len - 2 ) {
   my $diff = abs($numbers[ $pos ] - $numbers[ $pos + 1 ]) ;
   $sum += $diff ;
}
say $sum ;

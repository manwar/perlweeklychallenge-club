#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;

say "Enter some integers, separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
say "Enter another integer!" ;
my $k = <STDIN> ;
chomp $k ;
my $len = scalar( @numbers ) ;
my $sum = 0 ;
my @indices = (0..$len - 1 ) ;
my $iter = combinations(\@indices , 2 ) ;
while ( my $p = $iter->next ) {
   my $fst = $p->[0] ;
   my $snd = $p->[1] ;
   if ( $numbers[ $fst ] == $numbers[ $snd ] && ( ($fst * $snd) % $k == 0 )) {
      $sum++ ;
   }
}
say $sum ;


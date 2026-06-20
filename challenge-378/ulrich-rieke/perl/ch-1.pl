#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter an alphanumeric string!" ;
my $word = <STDIN> ;
chomp $word ;
my %letters ;
for my $letter( split( // , $word ) ) {
   if ( $letter =~ /\d/ ) {
      $letters{$letter}++ ;
   }
}
my $len = scalar( keys( %letters ) ) ;
if ( $len == 0 || $len == 1 ) {
   say -1 ;
}
else {
   my @sorted = sort { $b <=> $a } keys %letters ;
   say $sorted[1] ;
}

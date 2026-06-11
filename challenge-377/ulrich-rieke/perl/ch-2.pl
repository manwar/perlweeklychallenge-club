#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some strings separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my $len = scalar( @words ) ;
my $result = 0 ;
for my $i (0..$len - 2 ) {
   for my $j ($i + 1 ..$len - 1 ) {
      my $first = $words[$i] ;
      my $second = $words[$j] ;
      if ( $second =~ /^$first/ && $second =~ /$first$/ ) {
         $result++ ;
      }
   }
}
say $result ;

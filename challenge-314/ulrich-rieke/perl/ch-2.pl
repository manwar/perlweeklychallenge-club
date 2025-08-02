#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub isSorted {
   my $word = shift ;
   my $sorted = join( '' , sort split( // , $word )) ;
   return $word eq $sorted ;
}

say "Enter some words of equal length separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my $len = length $words[0] ;
my $wordnum = scalar @words ;
my @transposed ;
for my $i (0..$len - 1 ) {
   my $transpo ;
   for my $w (0..$wordnum - 1 ) {
      $transpo .= substr( $words[$w] , $i , 1 ) ;
   }
   push @transposed , $transpo ;
}
say scalar( grep { not isSorted( $_ ) } @transposed ) ;

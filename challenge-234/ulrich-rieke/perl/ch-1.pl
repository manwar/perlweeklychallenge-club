#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min ) ;

sub count {
   my $word = shift ;
   my $letter = shift ;
   return scalar ( grep { $_ eq $letter } split( // , $word ) ) ;
}

say "Enter some words, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my $len = scalar( @words ) ;
my %frequencies ;
for my $letter( split( // , $words[0] )) {
   $frequencies{ $letter }++ ;
}
for my $letter( keys %frequencies ) {
   my @counts = map { count( $_ , $letter ) } @words ;
   my $minimum = min( @counts ) ;
   if ( $minimum == 0 ) {
      delete $frequencies{ $letter } ;
   }
   else {
      $frequencies{ $letter } = $minimum ;
   }
}
my @result ;
for my $letter( sort keys %frequencies ) {
   for (0..$frequencies{ $letter } - 1 ) {
      push @result , $letter ;
   }
}
say "(" . join( ',' , @result) . ")" ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

sub findFrequencies {
   my $word = shift ;
   my %frequencies ;
   for my $letter( sort split( // , $word ) ) {
      $frequencies{ $letter }++ ;
   }
   return %frequencies ;
}

say "Enter an alphanumeric string!" ;
my $word = <STDIN> ;
chomp $word ;
say "Enter some alphabetic strings!" ;
my $line = <STDIN> ;
chomp $line ;
my @strings = split( /\s+/ , $line ) ;
my $allSmall ;
for my $letter( split( // , $word ) ) {
   if ( $letter =~ /[A-Z]/ ) {
      $allSmall .= lc( $letter ) ;
   }
   if ( $letter =~ /[a-z]/ ) {
      $allSmall .= $letter ;
   }
}
my %wordFreq = findFrequencies( $allSmall ) ;
my @selected ;
for my $aWord ( @strings ) {
   my %someWordFreq = findFrequencies( $aWord ) ;
   if ( all { exists( $someWordFreq{ $_ }) && $someWordFreq{ $_ } >= 
	    $wordFreq{ $_ } } keys %wordFreq ) {
      push( @selected , $aWord ) ;
   }
}
if ( @selected ) {
   my @sorted = sort { length( $a ) <=> length( $b ) } @selected ;
   say $sorted[0] ;
}
else {
   say " " ;
}

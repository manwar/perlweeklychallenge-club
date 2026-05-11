#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

say "Enter a string!" ;
my $word = <STDIN> ;
chomp $word ;
my %frequencies ;
map { $frequencies{$_}++ } split( // , $word ) ;
if ( all { $_ == 1 } values %frequencies ) {
   say -1 ;
}
else {
   my @most_frequent = grep { $frequencies{$_} > 1 } keys %frequencies ;
   my $max_distance = 0 ;
   for my $letter( @most_frequent ) {
      my $distance = rindex( $word , $letter ) - index( $word , $letter ) 
         - 1 ;
      if ( $distance > $max_distance ) {
         $max_distance = $distance ;
      }
   }
   say $max_distance ;
}


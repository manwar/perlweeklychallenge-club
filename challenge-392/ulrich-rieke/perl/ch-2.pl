#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;
use List::Util qw ( all ) ;

sub condition {
   my $combi = shift ;
   my $firstword = $combi->[0] ;
   my $secondword = $combi->[1] ;
   if ( all { index( $secondword , $_ ) == - 1 } split( // , $firstword ) ) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

say "Enter some strings separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my $iter = combinations( \@words , 2 ) ;
my $maxi = 0 ;
while ( my $c = $iter->next ) {
   if ( condition( $c ) ) {
      my $val = length( $c->[0] ) * length( $c->[1] ) ;
      if ( $val > $maxi ) {
         $maxi = $val ;
      }
   }
}
say $maxi ;

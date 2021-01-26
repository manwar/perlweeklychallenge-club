#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub findMapped {
  my $letter = shift ;
  my $n = shift ;
  if ( $letter eq ' ' ) {
      return ' ' ;
  }
  else {
      my $num = ord( $letter ) - $n ;
      if ( $num < 65 ) { #this is A, we must wrap to the end of the alphabet
    $num = 90 - ( 65 - $num ) + 1 ;
      }
      return chr $num ;
  }
}

my $S = $ARGV[ 0 ] ;
my $N = $ARGV[ 1 ] ;
my $num = $N % 26 ; #if a number greater than the number of letters is ent.
die "String $S should only consist of capital letters" unless ($S =~ /^[A-Z ]+$/) ;
say join( '' , map { findMapped( $_ , $num ) } split( // , $S ) ) ;

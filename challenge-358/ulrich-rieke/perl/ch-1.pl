#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

sub findLength {
   my $word = shift ;
   if ( $word =~ /^\d+$/ ) {
      return ( $word + 0 ) ;
   }
   else {
      return length( $word ) ;
   }
}

say "Enter some alphanumeric strings separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
say max( map { findLength( $_ ) } @words ) ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

sub convert {
   my $string = shift ;
   if ( $string =~ /\D/ ) {
      return length $string ;
   }
   else {
      return ($string + 0) ;
   }
}

say "Enter some strings, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @strings = split( /\s/ , $line ) ;
my @converted ;
for my $s ( @strings ) {
   push @converted , convert( $s ) ;
}
say max( @converted ) ;

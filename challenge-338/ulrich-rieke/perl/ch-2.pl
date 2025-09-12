#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;
use List::Util qw ( max ) ;

say "Enter some integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @firstnumbers = split( /\s+/ , $line ) ;
say "Enter some more integers separated by whitespace!" ;
$line = <STDIN> ;
chomp $line ;
my @secondnumbers = split( /\s+/ , $line ) ;
my @differences ;
for my $first ( @firstnumbers ) {
   for my $second ( @secondnumbers ) {
      push( @differences , abs( $first - $second )) ;
   }
}
say max( @differences ) ;


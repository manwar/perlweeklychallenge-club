#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

say "Please enter some sentences, fin to end entry!" ;
my @sentences ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ne "fin" ) {
  if ( $line !~ /^\S.+\S$/ ) {
      say "There should be no trailing spaces at the beginning and the end!" ;
      say "Re-enter!" ;
  }
  else {
      push @sentences, $line ;
  }
  $line = <STDIN> ;
  chomp $line ;
}
my @lengths ;
for my $sentence ( @sentences ) {
  my @words = split( /\s/ , $sentence ) ;
  push @lengths, scalar( @words ) ;
}
say max( @lengths ) ;

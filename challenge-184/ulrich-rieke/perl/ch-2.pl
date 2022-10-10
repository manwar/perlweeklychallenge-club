#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter single letters and digits, separated by a blank, <return> to end!" ;
my @list ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ) {
  push @list , $line ;
  $line = <STDIN> ;
  chomp $line ;
} ;
my @numberlist ;
my @letterlist ;
for my $str ( @list ) {
  my @currentNumbers ;
  my @currentLetters ;
  for my $l ( split( /\s/ , $str ) ) {
      if ( $l =~ /^[[:digit:]]$/ ) {
    push @currentNumbers , $l ;
      }
      if ( $l =~ /^[[:lower:]]$/ ) {
    push @currentLetters , $l ;
      }
  }
  if ( @currentNumbers ) {
      push @numberlist , '[' . join( ',' , @currentNumbers ) . ']' ;
  }
  if ( @currentLetters ) {
      push @letterlist , '[' . join( ',' , @currentLetters ) . ']' ;
  }
}
print ('[' . join( ',' , @numberlist ) . ']' . " and " ) ;
say ( '[' . join( ',' , @letterlist ) . ']' ) ;

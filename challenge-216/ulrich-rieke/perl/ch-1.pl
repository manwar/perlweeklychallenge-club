#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

sub condition {
  my $regi = shift ;
  my $word = shift ;
  return all { index( $word , $_ ) != -1 } split( // , $regi ) ;
}

say "Please enter some words, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
say "Please enter a registration number with 2 parts, separated by blanks!" ;
$line = <STDIN> ;
chomp $line ;
my @regiparts = split( /\s/ , $line ) ;
my $registration = $regiparts[ 0 ] . $regiparts[ 1 ] ;
my $relevant_word = join ( '' , grep { $_ =~ /[a-z]/ } split( // ,
lc $registration )) ;
say "(" . join( ',' , grep { condition( $relevant_word , $_ ) } @words ) . ")" ;

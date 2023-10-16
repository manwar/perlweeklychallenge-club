#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

#check whether all letters in a string are contained in a letter hash
sub myCondition {
   my $str = shift ;
   my $letterHash = shift ;
   return all { exists( $letterHash->{$_} ) } split( // , $str ) ;
}

say "Enter some strings, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @strings = split( /\s/ , $line ) ;
say "Enter an allowed string!" ;
my $allowed = <STDIN> ;
chomp $allowed ;
#enter all letters in $allowed into a letter hash
my %letterHash ;
for my $c( split( // , $allowed ) ) {
   $letterHash{ $c }++ ;
}
#check which strings comply with myCondition
my @consistent = grep { myCondition( $_ , \%letterHash ) } @strings ;
say scalar( @consistent ) ;

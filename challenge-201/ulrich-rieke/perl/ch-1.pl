#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my %found ;
map { $found{$_}++ } @numbers ;
my @missingNumbers ;
for my $n (0..$len ) {
  unless ( exists( $found{ $n } )) {
      push @missingNumbers , $n ;
  }
}
say join( ',' , @missingNumbers ) ;

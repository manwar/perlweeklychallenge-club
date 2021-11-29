#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter three integers!" ;
my $line = <STDIN> ;
chomp $line ;
while ( $line !~ /\A\s*(\d+\s*)+\z/ ) {
  say "Enter three integers, separated by a blank!" ;
  $line = <STDIN> ;
  chomp $line ;
}
my ( $i , $j , $k ) = (split( /\s/ , $line))[0 .. 2] ;
my @allNumbers ;
for my $num ( 1 .. $j ) {
  push @allNumbers , $num ;
}
for my $mult ( 2 .. $i ) {
  for my $num ( 1 .. $j ) {
      push @allNumbers, $mult * $num ;
  }
}
my @sorted = sort { $a <=> $b } @allNumbers ;
say $sorted[ $k - 1 ] ;

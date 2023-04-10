#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

say "Enter a matrix, consisting of lines of equal numbers of integers , end to end!" ;
my @matrix ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ne "end" ) {
  my @numbers = split( /\s/ , $line ) ;
  push @matrix , \@numbers ;
  say "Enter a line of integers, end to end!" ;
  $line = <STDIN> ;
  chomp $line ;
}
my @diagonals ;
my $len = scalar( @matrix ) ;
for my $i ( 0..$len - 1 ) {
  push @diagonals , $matrix[$i]->[$i] ;
}
if ( all { $_ == $diagonals[ 0 ] } @diagonals ) {
  say "true" ;
}
else {
  say "false" ;
}

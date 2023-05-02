#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all any ) ;

say "Enter 1's and 0's, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
say "Enter how many 0's are to be replaced!" ;
my $count = <STDIN> ;
chomp $count ;
#if we want to replace one 0 we have to have 3 in a row, if more than 1 ,
#then 3 + 0 to be replaced
my $len = scalar( @numbers ) ;
my $necessary ;
if ( $count == 1 ) {
  $necessary = 3 ;
}
if ( $count > 1 ) {
  $necessary = 3 + $count ;
}
if ( $len < $necessary || $len == $necessary ) {
  say 0 ;
}
else {
  my @results ;
  for my $i ( 0 .. $len - $necessary ) {
      my @removed = splice( @numbers, $i , $necessary ) ;
      if ( all { $_ == 0 } @removed ) {
    push @results , 1 ;
      }
      else {
    push @results, 0 ;
      }
      splice( @numbers, $i , $necessary, @removed ) ;
  }
  if ( any { $_ == 1 } @results ) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}

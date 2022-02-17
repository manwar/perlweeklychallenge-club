#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw( min ) ;

say "Enter integers separated by spaces! Enter e to end data entry!" ;
say "line by line, enter one more number than in the previous line!" ;
my $lastLen = 0 ;
my $len ;
my $pathSum = 0 ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ne "e" ) {
  while ( $line !~ /^(\d\s*)+$/ ) {
      say "Enter only integers separated by spaces, one more per line!" ;
      $line = <STDIN> ;
      chomp $line ;
  }
  unless ( $line eq "e" ) {
      $len = scalar( split( /\s+/ , $line ) ) ;
      while ( $len != $lastLen + 1 ) {
    say "There should be one number more per line!" ;
    $line = <STDIN> ;
    chomp $line ;
    $len = scalar( split( /\s+/ , $line ) ) ;
      }
  }
  $pathSum += min( split( /\s+/ , $line )) ;
  $lastLen = $len ;
  $line = <STDIN> ;
  chomp $line ;
}
say $pathSum ;

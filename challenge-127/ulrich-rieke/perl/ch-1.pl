#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( any ) ;

say "Enter 2 rows of integers, unique per row!" ;
my $line = <STDIN> ;
chomp $line ;
my @S1 = split( /\s+/ , $line ) ;
say "another line!" ;
$line = <STDIN> ;
chomp $line ;
my @S2 = split( /\s+/ , $line ) ;
my %S1 ;
for my $i ( @S1 ) {
  $S1{ $i }++ ;
}
if ( any { exists $S1{$_} } @S2 ) {
  say 0 ;
}
else {
  say 1 ;
}

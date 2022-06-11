#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max min ) ;

say "Enter 4 integers per rectangle to denote the lower left and upper right";
say "corner of the rectangles! Separate numbers by spaces!" ;
say "rectangle 1 =>" ;
my $line = <STDIN> ;
chomp $line ;
while ( $line !~ /^([+-]*\d+\s*)+$/ ) {
  say "please enter 4 numbers separated by spaces!" ;
  $line = <STDIN> ;
  chomp $line ;
}
my @firstNumbers = split( /\s+/ , $line ) ;
while ( scalar( @firstNumbers ) != 4 ) {
  say "Enter 4 numbers separated by spaces!" ;
  $line = <STDIN> ;
  chomp $line ;
  @firstNumbers = split( /\s+/ , $line ) ;
}
say "rectangle 2 =>" ;
$line = <STDIN> ;
chomp $line ;
while ( $line !~ /^([+-]*\d+\s*)+$/ ) {
  say "please enter 4 numbers separated by spaces!" ;
  $line = <STDIN> ;
  chomp $line ;
}
my @secondNumbers = split( /\s+/ , $line ) ;
while ( scalar( @secondNumbers ) != 4 ) {
  say "Enter 4 numbers separated by spaces!" ;
  $line = <STDIN> ;
  chomp $line ;
  @secondNumbers = split( /\s+/ , $line ) ;
}
my %firstXNumbers ;
my %firstYNumbers ;
my %secondXNumbers ;
my %secondYNumbers ;
for my $i ( $firstNumbers[0] .. $firstNumbers[2] ) {
  $firstXNumbers{ $i }++ ;
}
for my $i ( $firstNumbers[1] .. $firstNumbers[3] ) {
  $firstYNumbers{ $i }++ ;
}
for my $i ( $secondNumbers[0] .. $secondNumbers[2] ) {
  $secondXNumbers{ $i }++ ;
}
for my $i ( $secondNumbers[1] .. $secondNumbers[3] ) {
  $secondYNumbers{ $i }++ ;
}
my @commonX = grep { exists( $secondXNumbers{ $_ } ) } keys %firstXNumbers ;
my @commonY = grep { exists( $secondYNumbers{ $_ } ) } keys %firstYNumbers ;
my $firstArea = ( $firstNumbers[2] - $firstNumbers[0] ) * ( $firstNumbers[3] -
      $firstNumbers[1] ) ;
my $secondArea = ( $secondNumbers[2] - $secondNumbers[0] ) * ( $secondNumbers[3] -
      $secondNumbers[1] ) ;
if ( @commonX && @commonY ) {
  my $superPositionArea = ( max( @commonX) - min( @commonX ) ) * ( max( @commonY )
    - min( @commonY ) ) ;
  say ( $firstArea + $secondArea - $superPositionArea ) ;
}
else {
  say ( $firstArea + $secondArea ) ;
}

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

sub parseLine {
  my $line = shift ;
  my @points ;
  my @pairs = split (/\s+/ , $line ) ;
  for my $p ( @pairs ) {
      my @point = split( /\,/ , $p ) ;
      push @points , \@point ;
      }
  return @points ;
}

sub findLine {
  my $passedPoints = shift ;
  my $sumOfX = sum( map { $_->[0] } @{$passedPoints}) ;
  my $sumOfY = sum( map { $_->[1] } @{$passedPoints}) ;
  my $sumOfXY = sum( map { $_->[0] * $_->[1] } @{$passedPoints}) ;
  my $sumOfXsquare = sum( map { $_->[0] * $_->[0] } @{$passedPoints}) ;
  my $len = scalar( @{$passedPoints} ) ;
  my $m = ($len * $sumOfXY - $sumOfX * $sumOfY ) / ( $len *
    $sumOfXsquare - $sumOfX ** 2 ) ;
  my $b = ( $sumOfY - $m * $sumOfX ) / $len ;
  return ( $m , $b ) ;
}

my @points ;
say "Please enter a number of points!( 0 to end)" ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ne "0" ) {
  my @newPoints = parseLine( $line ) ;
  push @points , @newPoints ;
  $line = <STDIN> ;
  chomp $line ;
}
my ( $m , $b ) = findLine( \@points ) ;
say "The points entered are best fitted by a line with the equation y = $m x + $b!" ;
open ( my $fh , ">> testfile.svg" ) or die "Can't append to testfile.svg! $!\n" ;
say $fh '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' ;
print $fh '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN"' ;
say $fh '  "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">' ;
print $fh '<svg height="300" width="400" xmlns="http://www.w3.org/2000/svg"' ;
say $fh ' xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">' ;
say $fh '<g id="lines" stroke="#369" stroke-width="4">' ;
my $startx = 0 ;
my $endx = 400 ;
my $starty = $m * $startx + $b ;
my $endy = $m * $endx + $b ;
say $fh "  <line x1=\"$startx\" x2=\"$endx\" y1=\"$starty\" y2=\"$endy\"  />" ;
say $fh "</g>" ;
say $fh "<g fill=\"#f73\" id=\"points\">" ;
for my $p ( @points ) {
  say $fh "  <circle cx=\"$p->[0]\" cy=\"$p->[1]\" r=\"3\"  />" ;
}
say $fh " </g>" ;
say $fh "</svg>" ;
close $fh ;

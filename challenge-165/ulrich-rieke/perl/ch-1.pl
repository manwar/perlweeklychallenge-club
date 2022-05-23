#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

print "Enter a number of points, separated by , one per line, or lines," ;
say " made up of two points, separated by a ,!" ;
say "Enter 0,0 to end!" ;
my @lines ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ne "0,0" ) {
  while ( $line !~ /\A\d+\,\d+\z/ && $line !~ /\A\d+\,\d+\,\d+\,\d+\z/ ) {
      say "Wrong format! Enter either 2 or 4 numbers separated by commas!" ;
      $line = <STDIN> ;
      chomp $line ;
  }
  push @lines , $line ;
  $line = <STDIN> ;
  chomp $line ;
}
my @lineInputs = grep { $_ =~  /\A\d+\,\d+\,\d+\,\d+\z/ } @lines ;
my @pointInputs = grep { $_ =~ /\A\d+\,\d+\z/ } @lines ;
my $outfile = "myTestfile.svg" ;
open ( my $fh , ">> $outfile" ) or die "Can't append at $outfile: $!\n" ;
say $fh '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' ;
print $fh '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN"' ;
say $fh '  "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">' ;
print $fh '<svg height="600" width="800" xmlns="http://www.w3.org/2000/svg"' ;
say $fh ' xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">' ;
say $fh '<g id="lines" stroke="#369" stroke-width="4">' ;
for my $inputLine ( @lineInputs ) {
  my ( $x1 , $y1 , $x2 , $y2 ) = split( /\,/ , $inputLine ) ;
  say $fh "    <line x1=\"$x1\" x2=\"$x2\" y1=\"$y1\" y2=\"$y2\" />" ;
}
say $fh "</g>" ;
say $fh '<g fill="#f73" id="points">' ;
for my $point ( @pointInputs ) {
  my ( $cx , $cy ) = split( /\,/ , $point ) ;
  say $fh "  <circle cx=\"$cx\" cy=\"$cy\" r=\"3\" />" ;
}
say $fh "  </g>" ;
say $fh "</svg>" ;
close $fh ;

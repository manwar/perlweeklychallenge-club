#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

no warnings "experimental::signatures";

die "Specify 6 or 8 values" unless @ARGV == 6 || @ARGV == 8;

my ($x1, $y1, $x2, $y2, $x3, $y3, $x, $y) = @ARGV;

$x = 0 unless defined $x;
$y = 0 unless defined $y;

my $ABC = area($x1, $y1, $x2, $y2, $x3, $y3);
my $PBC = area($x,  $y,  $x2, $y2, $x3, $y3);
my $PAC = area($x1, $y1, $x,  $y,  $x3, $y3); 
my $PAB = area($x1, $y1, $x2, $y2, $x,  $y); 

($ABC == $PBC + $PAC + $PAB) ? say 1 : say 0;

sub area($x1, $y1, $x2, $y2, $x3, $y3) 
{ 
  return abs( ($x1 * ($y2 - $y3) + $x2 * ($y3 - $y1) + $x3 * ($y1 - $y2) ) / 2); 
} 

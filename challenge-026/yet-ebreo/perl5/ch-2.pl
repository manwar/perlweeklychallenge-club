# Create a script that prints mean angles of the given list of angles in degrees. 
# Please read wiki(https://en.wikipedia.org/wiki/Mean_of_circular_quantities) page 
# that explains the formula in details with an example.

use strict;
use warnings;
use v5.10;

use Math::Trig;

die "Usage:\n\tch-2.pl <angle1> .. <anglen>\n\n" if !@ARGV;
die "Only numbers are allowed as input\n" if "@ARGV"=~/[^0-9 ]/;

my ($y_comp,$x_comp) = 0;
$y_comp+=sin deg2rad($_),$x_comp+=cos deg2rad($_)  for @ARGV;
say rad2deg(atan2($y_comp,$x_comp));
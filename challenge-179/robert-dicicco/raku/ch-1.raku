use v6;

use Lingua::EN::Numbers :short;

# AUTHOR: Robert DiCicco
# DATE: 2022-08-22
# Challenge 179 Ordinal Number Spelling ( Raku )

my @arr = 11,62,99;

for @arr  {
  print "$_ => ", ord-n($_), "\n";
}

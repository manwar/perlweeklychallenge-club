#!perl.exe

use strict;
use warnings;
use Lingua::EN::Numbers qw/num2en_ordinal/;

# AUTHOR: Robert DiCicco
# DATE: 2022-08-22
# Challenge 179 Ordinal Number Spelling ( Perl )

my @arr = (11,62,99);

foreach (@arr) {
  print "$_ => ", num2en_ordinal($_), "\n";
}

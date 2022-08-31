#!perl.exe

use strict;
use warnings;

# AUTHOR: Robert DiCicco
# DATE: 2021-08-30
# Challenge 180 Trim List ( Perl )

my @arr = (
            [1,4,2,3,5],
            [9,0,6,2,3,8,5]
          );

my @nums = qw/3 4/;

my $count = 0;

while ($count < 2 ) {

  my @results = ();

  my $val = \$arr[$count];

  print("Input: \@n = \(@$$val\) and \$i = $nums[$count]\n");

  foreach (@$$val) {

    push(@results, $_) if ($_ >= $nums[$count]);

  }

  print("@results\n\n");

  $count++;

}

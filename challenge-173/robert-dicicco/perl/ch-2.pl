#!perl.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-07-13
# Challenge 173 Sylvbester's Sequence ( Perl )

use strict;
use warnings;
use bigint;
use List::Util qw/product/;

my @arr = (2);
my $count = 1;
my $prod = 1;

print("$arr[0]\n");

while (1) {

  $prod = product(@arr) + 1;

  print("$prod\n");

  push(@arr,$prod);

  $count++;

  last if ($count == 10);

}

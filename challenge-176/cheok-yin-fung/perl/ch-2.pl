# The Weekly Challenge 176
# Task 2 Reversible Numbers

use v5.30.0;
use warnings;

my @arr;
for (1..99) {
    push @arr, $_ if ($_ + (scalar reverse $_) ) =~ /^[13579]+$/ ;
}

say join ", ", @arr;


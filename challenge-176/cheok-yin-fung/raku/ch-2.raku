# The Weekly Challenge 176
# Task 2 Reversible Numbers
use v6;

my @arr;
for (1..99) {
    push @arr, $_ if ($_ + flip $_ ) ~~ /^<[13579]>+$/ ;
}

say join ", ", @arr;

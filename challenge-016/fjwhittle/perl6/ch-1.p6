#!/usr/bin/env perl6

#| Calculate which guest gets the largest slice of pie and what percentage that is.
unit sub MAIN(
  UInt $guests where * > 0 = 100 #= Number of guests, defaults to 100.
);

# Start with a whole pie
my FatRat $pie = 1.FatRat;

# Calculate slices.  0th guest to line up the indices, gets 0 anyway.
my @slices = (0..$guests).map: -> $n is copy {
  $n *= $pie / $guests;
  $pie -= $n;
  $n * 100; # As a percentage.
};

# .key is the guest number, .value is the percentage ofthe pie they get.
@slices.pairs.max(*.value).fmt('With %2$.2f%%, guest %1$d gets the most pie.').put;

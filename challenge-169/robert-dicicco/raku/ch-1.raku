use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-06-13
# Challenge 169 Brilliant Numbers ( Raku )

use Prime::Factor;

my @results;
my $count = 0;
my $n = 1;                # starting number to check

constant MAX_NUMBERS = 20;

while ($count < MAX_NUMBERS) {              # looking for the first 20 numbers

  my @factors = prime-factors($n);          # get the prime factors

  if ( @factors.elems == 2 ) {              # must have 2 prime factors

    my $firstval = @factors[0].comb.elems;  # get length of first factor

    my $secondval = @factors[1].comb.elems; # get length of second factor

    if ($firstval == $secondval) {          # are factor lengths equal ?

      @results.push:  $n;                   # if so, then save $n  to our array

      $count++;                             # and bump the count

    }

  }

  $n++;                                     # get next number to test

}

say @results;                               # print out the results array

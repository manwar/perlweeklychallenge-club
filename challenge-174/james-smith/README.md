[< Previous 173](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-173/james-smith) |
[Next 175 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-175/james-smith)

# The Weekly Challenge 174

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-174/james-smith

# Task 1 - Disarium Numbers

***Write a script to generate first 19 Disarium Numbers. A disarium number is an integer where the sum of each digit raised to the power of its position in the number, is equal to the number.***

## Solution

```perl
my $n = -1;
for(1..19) {
  my($c,$t) = (0,++$n);
  $t-= $_ ** ++ $c for split //,$n;
  $t ? (redo) : say $n;
}
```

### Complex map

```perl
$n = -1;
say for map { while(1) { my($c,$t)=(0,++$n); $t-=$_**++$c for split//,$n; $t || last }; $n } 1..19;

```

# Task 2 - Permutation Ranking

***You are given a list of integers with no duplicates, e.g. [0, 1, 2]. Write two functions, permutation2rank() which will take the list and determine its rank (starting at 0) in the set of possible permutations arranged in lexicographic order, and rank2permutation() which will take the list and a rank number and produce just that permutation.***

## Solution

The one obvious thing we don't want to do is generate a complete list of permutations and display that - so we have to work out an algoritm to convert rank to values!

```perl
sub permutation2rank {
  my($r,$f,@l,$c,$x) = (0,1,@{$_[0]}), my @p = @{$_[1]};
  $f *= $_ for 1 .. @l;
  O: for ( reverse 1 .. @l ) {
    $f/=$_, $c = 0, $x = shift @p;
    ($x-$_) ? $c++ : ( $r+=$c*$f, splice(@l,$c,1), next O ) for @l;
    return -1;
  }
  $r;
}

sub rank2permutation {
  my( $r, $f, @index, @res ) = ( $_[1], 1, 0 .. (my $n = my @l = @{$_[0]}) -1 );
  $f *= $_ for 1 .. $n;
  return [] if $r >= $f;  ## rank out of range!
  push @res, $l[ splice @index, ($r%=$f) / ($f/=$_), 1 ] for reverse 1..$n;
  \@res;
}
```

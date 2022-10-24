[< Previous 187](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-187/james-smith) |
[Next 189 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-189/james-smith)

# The Weekly Challenge 188

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-188/james-smith

# Task 1 - Divisible Pairs

***You are given list of integers `@list` of size `$n` and divisor `$k`. Write a script to find out count of pairs in the given list that satisfies the following rules.***


## Solution

We will try a number of different solutions. From some golfed solutions to a longer hand version...

 * The first version - we use a `while` loop to shift entries off the list. (This gives us the `$i<$j` constraint). We then use grep to get all the valid values and them to the count.
 * The second version replaces the `grep` with a `for` loop (and uses the `||` trick to avoid an inner `if`.
 * The 3rd - is a very muched golfed solution - in avoiding an array variable for the list. This unfortunately makes the function destructive in that it empties the array, inside and outside the function.
 * The 4th - makes a local copy of the array - so is non-destructive
 * Finally we don't pass an arrayref - but an array (and we put the `$k` variable at the front of the list

```perl

## Use grep for inner loop

sub divisible_pairs {
  my( $c, $k, @l ) = ( 0, $_[1], @{$_[0]} );
  while(@l>1){
    my $a = shift@l;
    $c+=grep{ !(($a+$_)%$k) } @l;
  }
  $c
}

## Use for for inner loop

sub divisible_pairs_x {
  my( $c, $k, @l ) = ( 0, $_[1], @{$_[0]} );
  while(@l>1){
    $a = shift@l;
    ($a+$_)%$k || $c++ for @l;
  }
  $c
}

sub dp       { 0 + map { $a = pop @{$_[0]}; grep { !(($a+$_)% $_[1]) } @{$_[0]} } 1..@{$_[0]} }
sub dp_nd    { my @T=@{$_[0]}; 0 + map { $a = pop @T; grep { !(($a+$_)%$_[1]) } @T} 1..@T     }
sub dp_other { $b=shift; 0+map{$a=pop;grep{!(($a+$_)%$b)}@_}1..@_                             }
```

Performance wise the we have:

| version           | Rate | Rel performance |
| :---------------- | ---: | --------------: |
| divisible_pairs_x | 150k |           1.45x |
| divisible_pairs   | 130k |           1.25x |
| dp_other          | 133k |           1.3x  |
| dp_nd             | 124k |           1.2x  |
| dp                | 103k |           1.0x  |

# Task 2 - Total Zero

***You are given two positive integers $x and $y.  Write a script to find out the number of operations needed to make both ZERO. Each operation is made up either of the followings:***

## Solution

We can just step through one at a time - where we subtract either `y` from `x` or `x` from `y` repeatedly and increment the count.

We can also short cut this - by reducing `y` to `y%x` or `x` to `x%y`, and increasing `t` by `|y/x|`...

This version - even for the example data is around 20-25% faster. For larger `x` & `y` we see a much greater increase in performance...

```perl
sub total_zero {
  my($t,$x,$y) = (0,@_);
  ($t,$x,$y) = $x > $y ? ($t+int($x/$y),$y,$x%$y) : ($t+int($y/$x),$x,$y%$x) while $x&&$y;
  $t
}

sub total_single_step {
  my($t,$x,$y) = (0,@_);
  ($t,$x,$y) = $x > $y ? ($t+1,$y,$x-$y) : ($t+1,$x,$y-$x) while $x&&$y;
  $t
}
```

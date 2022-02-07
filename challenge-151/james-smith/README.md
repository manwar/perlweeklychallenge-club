[< Previous 150](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-150/james-smith) |
[Next 152 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-152/james-smith)
# Perl Weekly Challenge #151

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-151/james-smith

# Challenge 1 - Binary Tree Depth

***You are given binary tree. Write a script to find the minimum depth. The minimum depth is the number of nodes from the root to the nearest leaf node (node without any children).***

## The solution


The method is to:
 * Split the string into the individual rows.
 * For each row check to see if the row is complete {has enough entries so that there are no parent nodes with no data}
   * If there are less than `2**$d-1` entries then this row is "incomplete" and we return the depth.
 * Check that there is no pair (with the same parent) for which both nodes are "`*`". Or if it is the last pair that it
   contains a single "*". If either of the case the row is "incomplete" and we return the depth.

```perl
sub depth {
  my $d = 0;
  for ( split m{\s*\|\s*}, $_[0] ) {
    last if scalar @{[m{\S+}g]} < 2**$d - 1
      || m{^\s*(?:\S+\s+\S+\s+)*?(\*\s+\*|\*\s*$)};
    $d++;
  }
  $d;
}
```

# Challenge 2 - Rob the House

***You are planning to rob a row of houses, always starting with the first and moving in the same direction. However, you can’t rob two adjacent houses. Write a script to find the highest possible gain that can be achieved.***

## The solution

We use a recursive solution. For any house the best solution can be found by. Either adding the value of the current house to the best solution for 2 doors down OR adding the value of the next house to the best solution for 3 doors down.

```perl
sub rob {
  my @b = my $v = shift;
  $b[$_]=$b[$_-1]<($v=($_>1&&$b[$_-2])+shift)?$v:$b[$_-1]while@_;
  $b[-1];
sub rob {
  my @b = shift;
  (push @b,$_+(@b>1&&$b[-2])),$b[-1]<$b[-2]&&($b[-1]=$b[-2]) for @_;
  $b[-1];
}

}

```


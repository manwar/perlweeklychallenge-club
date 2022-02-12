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
   * We have an array/list difference here `scalar m{\S+}g` returns `1`, `scalar @{[m{\S+}g]}` returns the number of matches!
 * Check that there is no pair (with the same parent) for which both nodes are "`*`". Or if it is the last pair that it
   contains a single "`*`".
   * If either of the case the row is "incomplete" and we return the depth.

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

We can walk along the house and work out what the best score we could get if we stopped the journey at any house. As we add in each extra house - best score depends on the best score of one of the last two houses visited and the points of the current house.

We will only ever skip one or two houses at each "jump", we will never skip more than two. There is always a better option which is to select one of the nodes in the middle. So the jump from 1 to 5 (skipping three) will always score less than the jump from 1 to 3 and 3 to 5. This is because you will miss plundering house No 3....

```
  ======     ======     ======     ======     ======     ======
 ========   ========   ========   ========   ========   ======== 
 | No 1 |   | No 2 |   | No 3 |   | No 4 |   | No 5 |   | No 6 | 
 --------   --------   --------   --------   --------   --------
    |  |                |    |                |  |
    |   `--->------>---'      `--->------>---'   |
    |                                            |
     `--->------>------>------>------>------>---'
```

### First attempt ...

Here we construct and array of the best total we could achieve if we stopped at the 1st, 2nd, 3rd houses etc...

For the first two:
  * best score for first house is the points for the first house.
  * best score for the 2nd house is the maximum of the points for the first and second houses.
For the rest
  * best score for subsequent houses. Is either the points for the house added to the best score of the house before last which was visited **OR** the best score of the last house visited.

We keep repeating the 2nd part until we get to the end house - and this gives us our score...

```perl
sub rob {
  my @b = shift;
  (push @b,shift    ), $b[-1]<$b[-2] && ($b[-1]=$b[-2]) if  @_;
  (push @b,$_+$b[-2]), $b[-1]<$b[-2] && ($b[-1]=$b[-2]) for @_;
  $b[-1];
}
```

*We could have written the second line with `1` & `0` not `-1` and `-2` but there is something about the symmetry of the two lines which is poetic*

### Second attempt ...

As we only need the previous 2 houses, we can do away with the array and just work with the score of the two previous entries.

```perl
sub rob_no_array {
  my$p=my$q=0;
  ($p,$q)=($q,$q>$p+$_?$q:$p+$_)for@_;
  $q;
}
```

Speedwise this is about 10% faster...

# Perl Weekly Challenge #125

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-125/james-smith/perl

# Task 1 - Pythagorean Triples

***You are given a positive integer `$N`. Write a script to print all Pythagorean Triples containing `$N` as a member. Print `-1` if it can’t be a member of any. Triples with the same set of elements are considered the same, i.e. if your script has already printed (3, 4, 5), (4, 3, 5) should not be printed.***

## The solution

There are two cases to consider - whether `$N` is the hypotenuse or one of the shorter sides.

 * `$N` is the hypotenuse - we just need to work out whether `$N**2 - $a**2` is a square for `$a` between `3` and `$N/sqrt 2`

 * `$N` is not the hypotenuse - we need to loop through `$a` from `$N+1` such that `$a**2-$N**2` is a square.

This gives:
```perl
sub get_triples {
  my $n = shift;
  return $n < 3 ? -1 : join '; ', map { sprintf '(%s)', join ', ', @{$_} }
  (
    grep { $_->[1] == int $_->[1] }                ## Check if all int
    map  { [ $_, sqrt($n**2-$_**2), $n ] }         ## Generate triple
    3 .. sqrt($n**2/2)                   ## Shortest side ($n is hypotenuse)
  ),(
    map  { $_->[0]>$_->[1] ? [@{$_}[1,0,2]] : $_ } ## put in numerical order
    grep { $_->[1] == int $_->[1] }                ## Check all int
    map  { [ $n, sqrt($_**2-$n**2), $_ ] }         ## Generate triple
    ($n+1) .. ($n**2/2+1)       ## Hypotenuse ($n is one of other two sides)
  );
}
```
# Task 2 - Binary Tree Diameter

*** Write a script to find the diameter of the given binary tree. The diameter of a binary tree is the length of the longest path between any two nodes in a tree. It doesn’t have to pass through the root.***

## Solution

For any node - we can compute the longest tree which goes through the node itself - this is the sum of the maximum lengths of the left tree and the depth of the right. We do know that there will be trees for which this is not the diameter - there could be another node for which the left and right depths sum to a larger value...

So to compute the diameter of the tree we just choose the maximum value of the maximum lengths of the left/right sub tree.

We will re-use the BinaryTree module from a previous challenge and so need to define walk functions to work out the maximum length of a subtree and consequently diameter...

```perl
sub max_length {
  my $self = shift;
  my $d = 0;
     $d = $self->left->max_length if $self->has_left;
  return 1+$d unless $self->has_right;
  my $t = $self->right->max_length;
  return $t > $d ? 1+$t : 1+$d;
}

sub diameter {
  my $self = shift;
  my $global = { 'diameter' => 0 };
  $self->walk( sub {
    my $d = ($_[0]->has_left  ? $_[0]->left->max_length  : 0 ) +
            ($_[0]->has_right ? $_[0]->right->max_length : 0 );
    $_[1]{'diameter'} = $d if $d > $_[1]->{'diameter'};
  }, $global );
  return $global->{'diameter'};
}
```

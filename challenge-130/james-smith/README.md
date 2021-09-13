# Perl Weekly Challenge #130

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-130/james-smith/perl

# Task 1 -  Odd Number

***You are given an array of positive integers, such that all the numbers appear even number of times except one number.***

## The solution

For each of the inputs we need to keep a tally of how many times we've seen them (or more simply if we have seen them an odd or even number of times). To achieve the latter we use the **xor** operator or `^` in perl.

For each number we update the "count" to be 0 if 1 and 1 if 0, using `$x{$_}^=1`.

Only entries for which `$x{$_}` is "true" have odd counts. So we get the (only one) odd count by `grep`ing the list and returning the (1) key.

```perl
sub find_odd {
  my %x;
  $x{$_}^=1 foreach @{$_[0]};
  return ( grep { $x{$_} } keys %x )[0];
}
```

# Task 2 - Binary Search Tree

***You are given a tree.  Write a script to find out if the given tree is Binary Search Tree (BST).***

## Solution

For a given tree to be a Binary Search Tree:

* Any sub-tree is also a Binary Search Tree;
* The maximum value of any left child is less than the value of the node;
* The minimum value of any right child is greater than the value of the node;

So we have a tree is not a BST IF

* It has a left child   && left sub tree is not a BST
* It has a left child   && max( left  sub tree ) > node value

* It has a right child  && right sub tree is not a BST
* It has a right child  && min( right sub tree ) < node value

We combine that into the is_bst function below:

```perl
sub is_bst {
  my $tr = shift;
  return ( $tr->has_left  && ( max($tr->left)  > $tr->value || ! is_bst( $tr->left ) ) )
      || ( $tr->has_right && ( min($tr->right) < $tr->value || ! is_bst( $tr->right) ) )
       ? 0 : 1;
}
```

The two supporting functions `max` & `min` are supplied below. Note they are
very similar just switching the nested call and the inequalities.

```perl
sub max {
  my $tr = shift;
  my $m = $tr->value;
  if( $tr->has_left  ) { my $t = max( $tr->left );  $m = $t if $t > $m; }
  if( $tr->has_right ) { my $t = max( $tr->right ); $m = $t if $t > $m; }
  return $m;
}

sub min {
  my $tr = shift;
  my $m = $tr->value;
  if( $tr->has_left  ) { my $t = min( $tr->left  ); $m = $t if $t < $m; }
  if( $tr->has_right ) { my $t = min( $tr->right ); $m = $t if $t < $m; }
  return $m;
}
```

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

```perl
sub find_odd {
  my %x;
  $x{$_}++ foreach @{$_[0]};
  return ( grep { $x{$_}&1 } keys %x )[0];
}
```

# Task 2 - Binary Search Tree

***You are given a tree.  Write a script to find out if the given tree is Binary Search Tree (BST).***

## Solution

```perl
sub is_bst {
  my $tr = shift;
  return ( $tr->has_left  && ( max($tr->left)  > $tr->value || ! is_bst( $tr->left ) ) )
      || ( $tr->has_right && ( min($tr->right) < $tr->value || ! is_bst( $tr->right) ) )
       ? 0 : 1;
}

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

[< Previous 144](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-144/james-smith) |
[Next 146 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-146/james-smith)
# Perl Weekly Challenge #145

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-145/james-smith

# Challenge 1 - Dot product

***You are given 2 arrays of same size, `@a` and `@b`. Write a script to implement Dot Product.***

## The solution

This challenge is simple - Relatively simple one to start with this week. We keep a running total of the product of corresponding entries in each of the arrays.

In this case we use one array as the basis of the loop, and shift off elements of the other array.

```perl
sub dot_product {
  my ($t,@y) = (0,@{$_[1]});
  $t += $_ * shift @y foreach @{$_[0]};
  $t;
}
```

# Challenge 2 - Palindromic Tree

***You are given a string `$s`. Write a script to create a Palindromic Tree for the given string.***

## The solution

This was one of the hardest challenges over recent weeks - not the implementation but understanding how/what this does.

Creating the tree is relatively straight forward. We start with the two "empty" nodes, and for each letter or pair of
adjacent letters which are the same we add the node as children (connected by edges), and also a back link to the
first/last letter.

```perl
sub eertree {
  my $str = [ split //, $_[0] ];
  my $tree = {
    -1  => { 'start' => undef, 'edges' => {}, 'suff' => -1 },
    q() => { 'start' => undef, 'edges' => {}, 'suff' => -1 },
  };
  add_str( $tree, $str, -1, $_, $_   ),
  add_str( $tree, $str, q(), $_, $_+1 ) for 0.. @{$str}-1;
  $tree;
}
```

In `add_str` we:

 * check that we are still in bounds and that the first and last letters are the same;
 * we create a link from the current node to the new node;
 * we create the new node if it didn't already exist;
 * we then expand the palindrome by a character at the front/end and repeat until we
   are out of bounds or we don't have a palindrome.

```perl
sub add_str {
  my( $tr, $c, $node, $st, $en ) = @_;
  while( $st >=0 && $en < @{$c} && $c->[$st] eq $c->[$en] ) {
    $tr->{$node}{'edges'}{my $s = join q(), @{$c}[$st..$en] } ||= keys %{$tr->{$node}{'edges'}};
    $tr->{$node=$s} ||= { 'start' => $st, 'edges' => {}, 'suff' => $st==$en ? -1 : $en==$st+1 ? q() : $c->[$st] };
    $st--;
    $en++;
  }
}
```

To generate the output required in the tests we flatten the string by sorting the nodes into the order of their first appearance (and length)
```perl
sub stringify {
  my $tree = shift;
  return join q( ),
         sort { $tree->{$a}{'start'} <=> $tree->{$b}{'start'} ||
                length $a <=> length $b }
         grep { defined $tree->{$_}{'start'} }
         keys %{$tree};
}
```

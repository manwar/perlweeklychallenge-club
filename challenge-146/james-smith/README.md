[< Previous 145](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-145/james-smith) |
[Next 147 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-147/james-smith)
# Perl Weekly Challenge #146

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-146/james-smith

# Challenge 1 - 10,001st Prime Number

***Write a script to generate the 10,001st prime number.***

## The solution

We could use a Prime module, but finding primes is not that difficult so we will roll our own generator.

```perl
my($c,@p)=(5,3);
for(;@p<10000;$c+=2){
  ($_*$_>$c)?((push@p,$c),last):$c%$_||last for@p;
}
say$p[-1];
```

The crux of the code is in the `for @p` line. This sees if a given odd number is prime.

We loop through all the primes up to and including the square root of the value we are checking.
If we don't find a prime factor by then we push the new value to the primes list, and go on to
try the next number. If we find a factor we skip the rest of the loop and go on to try the next number.

We stop when we have 10,000 records in the array (as we don't include the prime number 2 in the list - we
explicitly exclude even numbers in the list we search over), so the last element is the 10,001st prime.

# Challenge 2 - Curious Fraction Tree

***The tree below is defined by the following rules. For a fraction `a/b` the children are `a/(b+a)` & `(a+b)/b`. Given a node in the tree `n/m` we need to find the pate back up to the root node.***

```
                                     1/1
                                      |
                  +-------------------+-------------------+
                 1/2                                     2/1
                  |                                       | 
        +---------+---------+                   +---------+---------+
        |                   |                   |                   |
       1/3                 3/2                 2/3                 3/1
        |                   |                   |                   |
   +----+----+         +----+----+         +----+----+         +----+----+
   |         |         |         |         |         |         |         |
  1/4       4/3       3/5       5/2       2/5       5/3       3/4       4/1
   |         |         |         |         |         |         |         |
 +-+-+     +-+-+     +-+-+     +-+-+     +-+-+     +-+-+     +-+-+     +-+-+
 |   |     |   |     |   |     |   |     |   |     |   |     |   |     |   |
1/5 5/4   4/7 7/3   3/8 8/5   5/7 7/2   2/7 7/5   5/8 8/3   3/7 7/4   4/5 5/1
```

## The solution

We note if the node is `N/D` and the parent node is `n/d`:
* To get the parent of the left child we note that `n+d = D` and `n = N`, so the parent denominator is `N-D` and numerator doesn't change
* To get the parent of the right child we note that `n = N+D` and `d = D`, so the parent numerator is `N-D` and denominator doesn't change.
* For all nodes the numerator/denominator are co-prime.

We repeat this until `n` and `d` are the same - in the tree above both will have a value of `1`. If the initial numbers of not co-prime. The function stops when `n` and `d` are both the greatest common divisor of `n` and `d`.

The `stringify` function just converts the tree into a single string (list of fractions) so we can test the tree code.

```perl
sub tree {
  my@tr=[my($n,$d)=@_];
  push@tr,$d>$n?[$n,$d-=$n]:[$n-=$d,$d]while$n-$d;
  \@tr;
}

sub stringify {
  "@{[map{join'/',@{$_}}@{$_[0]}]}";
}

sub tree_expanded {
  my ($n,$d) = @_;
  my $traverse = [ [ $n, $d ] ];
  while( $n != $d ) {
    if($d>$n) {
      $d -= $n;
    } else {
      $n -= $d;
    }
    push @{$traverse}, [ $n, $d ];
  }
  return $traverse;
}

sub stringify_expanded {
  my traverse = $_[0]; ## Ref passed
  return join ' ',
         map { $_->[0].'/'.$_->[1] }
         @{ $traverse };
}
```
**Notes**
  * In the tree function we work with an array, and return it's reference (the last result is returned if no explicit `return` is given, so if you are returning from the last command in the function you do not have to include the `return` keyword.) This just makes for shorter code.
  * Rather than using an `if/else` we use a ternary ` ? : ` to implement the same switch - and we update `$d` and `$n` when we create the new element to the array. This allows us to embed the code in a postfix `while`.
  * Rather than using `$n==$d` we use `$n-$d` to save 1 byte but these are essentially the same in an if statement.
  * In `stringify` we use a number of tricks for compactness. Rather than using explicit `$n.'/'.$d` we note that we can rewrite as a join. But where we want to join on `" "` we can use the fact that if you embed an array in a string "@a" it does an implicit join on `" "`. You can then embed any code within a string by wrapping it in `@{[` & `]}`

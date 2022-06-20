[< Previous 169](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-169/james-smith) |
[Next 171 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-171/james-smith)

# The Weekly Challenge 170

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-170/james-smith

# Challenge 1 - Primordial Numbers

***Write a script to generate first 10 Primorial Numbers - like factorials but multiply by succesive primes***

## Solution

Another prime problem, in this one we revert to using next_prime to get successive primes. We use a couple more of the methods from `Math::Prime::Util`, `nth_prime` and `forprimes`.

`forprimes {block} $n` executes `{block}` with primes up to and including `$n`. This isn't quite what we want as we want to have `$n` primes - we can get the *n*th prime with suprisingly `nth_prime`. Combining the two gices us `forprimes {block} nth_prime $n`.

We use `bignum` to allow arbitrary integers, so can compute the primordial numbers for large `$n`. In this case to pretty print we use the `commify` method from the perl cookbook {here renamed `th`}. To pretty print the numbers. To right align these numbers we need the maximum length of the numbers - which is `log($x[-1])/log(10)` to get the digits and multiple by 4/3 to add the commas and add 2 for good measure...

```perl
my @x = (1); forprimes { push @x, $x[-1] * $_ } nth_prime ($ARGV[0]//10);

say sprintf '%'.int(2+4/3*log($x[-1])/log 10).'s', th($_) for @x;

sub th { scalar reverse( (reverse $_[0]) =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/gr ) }
```

# Challenge 2 - Kronecker Product

***Write a script to implement Kronecker Product on the given 2 matrices. e.g.***

## Example

Hard to describe - but here is an example.... see https://en.wikipedia.org/wiki/Kronecker_product
```
A = [ 1 2 ]  B = [ 5 6 ]
    [ 3 4 ]      [ 7 8 ]

A x B = [ 1 x [ 5 6 ]  2 x [ 5 6 ] ]  = [ 1x5 1x6 2x5 2x6 ]  = [  5  6 10 12 ]
        [     [ 7 8 ]      [ 7 8 ] ]    [ 1x7 1x8 2x7 2x8 ]    [  7  8 14 16 ]
        [ 3 x [ 5 6 ]  4 x [ 5 6 ] ]    [ 3x5 3x6 4x5 4x6 ]    [ 15 18 20 24 ]
        [     [ 7 8 ]      [ 7 8 ] ]    [ 3x7 3x8 4x7 4x8 ]    [ 21 24 28 32 ]
```

## Solution

Arrays are just lists of lists, and so we can use constructs like `map` and `for` to process these.
In this case we don't need to use `for`s as we can use `map` in all cases.

This is one of those cases where writing the code is easier than explaining what it does.

We have 4 `map`s... The outer two loop over the rows of `A` and `B` respectively, the inner two loop over
the entries in those rows (from matricies `A` and `B` respectively. Because the "loop variable" is `$_`
for each `map` the first thing we do in all but the inner loop is assign it to another variable.

```perl
sub k_product {
  [ map { my $r = $_; map { my $t = $_; [ map { my $s=$_; map { $s*$_ } @{$t} } @{$r} ] } @{$_[1]} } @{$_[0]} ]
}

```

Now we can use some of our "optimization" techniques to make this slightly smaller. Firstly we use
special variables, `$a`, `$b` and `$'` to replace the variables `$r`, `$s`, `$t` above. We also assign `$_`
to `$'` using the regex trick `//` which does this under the hood. We also remove the optional brackets
around `{$a}` & `{$b}` where dererencing.

This gives a slightly more compact version (73 characters!)

```perl
sub k{[map{$b=$_;map{$a=$_;[map{//;map{$'*$_}@$a}@$b]}@{$_[1]}}@{$_[0]}]}
```

Solution by James Smith

## Problem 1 ... perfect numbers...

There are two ways to go about this problem... Firstly sieve all the numbers to find those that are perfect OR to use the fact that the only perfect numbers that have been found have the form:

> _2<sup>p-1</sup>*(2<sup>p</sup>-1)_

where p is prime and 2<sup>p</sup>-1 is a prime - or Mersenne prime...

The perl 5 solution for this is elegant - but the perl 6 is evan more beatiful - by using `lazy gather` we create a generator..

```perl6
my @perfect = lazy gather {
  my $q = 1;
  take $q*($q+1)/2 if (++($q+<=1)).is-prime while 1;
}
```

Things to note... the sequence `++($q+<=1)` generates a list of numbers of the form _2<sup>n</sup>-1_. `$q+<=1` shifts each number 1 bit to the left - which is effectively multiplying by _2_ and ++ just increments the number by _1_.

> _2(2<sup>n</sup>-1)+1 = 2<sup>n+1</sup> - 2 + 1 = 2<sup>n+1</sup> - 1_

Note we don't check p for being prime in this case as the value of p is small so the check on `$q` is fast, _2<sup>p</sup>-1_ is only prime if _p_ is, as if _p_ is composite than we can write it as _mn_ and:

> _2<sup>p</sup>-1 = 2<sup>mn</sup>-1 = (2<sup>n</sup>-1)(1+2<sup>n</sup>+2<sup>2n</sup>+...+2<sup>(m-1)n</sup>)_

So _2<sup>p</sup>-1_ is also composite.

The extra check slows the process down.

Under perl6 with arbitrary precision this gets the first 20 perfect numbers in around 17-18 seconds, and the first 25 in around 30 minutes. The largest of these with 13,066 digits.

In this case the check for prime is slower with larger numbers so including the additional prime check on $p speeds this up by about 10%, and the generator becomes...

```perl6
my @perfect = lazy gather {
  my $q = 1, $p = 1;
  take $q*($q+1)/2 if (++($q+<=1)) && (++$p).is-prime and $q.is-prime while 1;
}
```




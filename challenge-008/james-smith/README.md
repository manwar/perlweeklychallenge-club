Solution by James Smith

## Problem 1 ... perfect numbers...

There are two ways to go about this problem... Firstly sieve all the numbers to find those that are
perfect OR to use the fact that the only perfect numbers that have been found have the form:

> 2<sup>p-1</sup>*(2^<sup>p</sup>-1)

where p is prime and 2<sup>p</sup>-1 is a prime - or mersenne prime...

The perl 5 solution for this is elegant - but the perl 6 is evan more beatiful - by using lazy gather we create a generator..

```perl6
my @perfect = lazy gather { my ($p, $q = 1; take $q*($q+1)/2 if (++($q+<=1)).is-prime while 1; }
```

Things to note... the sequence ++($q+<=1) generates a list of numbers of the form 2<sup>n</sup>-1.



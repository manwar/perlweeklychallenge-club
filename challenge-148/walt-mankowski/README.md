Solutions by Walt Mankowski.

# Task #1: Eban Numbers

For this task we need to write a script to generate all **Eban Numbers** <= 100. An Eban number is a number that has no letter 'e' in it when the number is spelled in English (American or British).

I used the CPAN module `Lingua::EN::Numbers`, which
> provides a function "num2en", which converts a number (such as 123) into English text ("one hundred and twenty-three").

Using `num2en` we can generate the Eban numbers with a single line of code:
```perl
my @eban = grep { num2en($_) !~ tr/e// } 1..100;
```

# Task 2: Cardano Triplets

For this task we need to generate the first 5 **Cardano Triplets**. The formula for Cardano Triplets involves square and cube roots. Github's Markdown engine doesn't support inline math, so I'll refer the reader to a [Project Euler](https://projecteuler.net/problem=251) problem involving them.

There's no obvious method to sort Cardano Triplets, so instead of generating the first 5, I decided to generate all the solutions where a, b, and c are all less than or equal to 100. I didn't use anything fancy to generate them, just 3 nested `for` loops.

The only real difficulty here is that the second cube root term is often negative. This is the case for the example of (2,1,5) given in the problem description. Like all nonzero real numbers, 2 - sqrt(5) has exactly one real cube root, but since it's negative Perl's `**` operator returns `NaN`. To get around this I take the cube root of the absolute value, then make it negative:

```perl
my $tmp = $a - $b * sqrt($c);
my $t2 = ($tmp >= 0) ? $tmp ** $THIRD : -abs($tmp) ** $THIRD;
```

Also, since we're dealing with floating point numbers and potential round off errors, we'll accept it as a match if the sum is within epsilon of 1:
```perl
my $EPS = 1e-6;
...
if (abs($t1 + $t2 - 1) < $EPS) {
    say "($a, $b, $c) ", $a + $b + $c ;
}
```

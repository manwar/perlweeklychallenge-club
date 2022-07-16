Solutions by Walt Mankowski.

# Perl Weekly Challenge #173: Esthetic Numbers and Sylvester's Sequence

## Task #1: Esthetic Numbers

For this task we're given a number _n_ and need to determine if it's an Esthetic Number. An **Esthetic Number** is a positive integer where every pair of adjacent digits differ in value by exactly 1.

The only real trick to solve this in Perl is that we can turn a number `$n` into an array of digits `@d` with the statement `@d = split //, $n;`. Then we can wrap that in a function that checks the absolute value of each pair of points:

```perl
sub is_esthetic($n) {
    my @d = split //, $n;
    for my $i (1..$#d) {
        return 0 unless abs($d[$i-1] - $d[$i]) == 1;
    }
    return 1;
}
```

## Task 2: Sylvester's Sequence

For this task we need to generate the first 10 terms of (Sylvester's Sequence)[https://en.wikipedia.org/wiki/Sylvester%27s_sequence]. **Sylvester's Sequence** is an integer sequence where every term is the product of all the previous terms, plus one.

Terms in Sylvester's Sequence get very large very fast (the 10th term has 20 digits) so we need to use the `bigint` module. I also used the `prod` function from `List::Util` to do the multiplication. With those modules in hand, we can solve this challenge in just a few lines of code:

```perl
use bigint;
use List::Util qw(product);

my @sylvester;
push @sylvester, 1 + product @sylvester while @sylvester < 10;
say for @sylvester;
```
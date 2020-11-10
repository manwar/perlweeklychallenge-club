Solutions by Walt Mankowski.

# Task #1: Pair Difference

For this task we're given an array numbers `n`, and we need to check there
exists a pair of numbers whose difference is a given value `a`. 

To solve this I used
[Algorithm::Combinatorics](https://metacpan.org/pod/Algorithm::Combinatorics)
to generate all the pairs of elements in `n`, then checked to see if
the absolute value of their difference was `a`:

```perl
my $res = 0;
my $iter = combinations(\@n, 2);
while (my $c = $iter->next) {
    if (abs($c->[0] - $c->[1]) == $a) {
        $res = 1;
        last;
    }
}

say $res;
```

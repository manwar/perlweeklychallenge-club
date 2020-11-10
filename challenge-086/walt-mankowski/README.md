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

# Task #2: Sudoku Puzzle

In this task we need to solve a Sudoku puzzle. I used
[Games::Sudoku::Lite](https://metacpan.org/pod/Games::Sudoku::Lite) to
solve the puzzle. Now, some might argue that this is cheating, but I
don't think so. If it's OK to use a combinatorics module to solve task
1, surely it's also OK to use a Sudoku module to solve task 2!

In fact that's the same conclusion I reached when a Sudoku problem
came up in [Project Euler](https://projecteuler.net/problem=96). I
just had to tweak my parsing code a bit from the code I wrote back
then and I was good to go.

Solutions by Walt Mankowski.

# Task #1: GCD Sum

For this task we're given a positive integer N. We need to find the sum of the greatest common divisors (GCDs) of all the pairs of integers between 1 and N.

There's a simple recursive formula for the GCD:
```perl
sub gcd($a, $b) {
    return $b == 0 ? $a : gcd($b, $a % $b);
}
```
Once we have that the solution can be easily calculated using 2 nested loops:
```perl
my $sum = 0;
for my $i (1..$n-1) {
    for my $j ($i+1..$n) {
        $sum += gcd($j, $i);
    }
}

say $sum;
```

# Task 2: Magical Matrix

For this task we need to create a 3 x 3 magic square; i.e. a matrix where each row, column, and diagonal sums to the same value. We're restricted to the numbers 1-9, so the sums should all be 15.

This is trivial in Matlab and Octave since there's a built in function to create magic squares, so all we need to do is say
```Matlab
magic(3)
```

We have to do a bit more work in Perl, but fortunately there's a simple algorithm for creating these sorts of magic squares called the [Siamese method](https://en.wikipedia.org/wiki/Siamese_method). It works for any m x m magic square where m is odd. Here's the algorithm:
1. Start with a 1 in the middle column of the top row.
2. For each subsequent number, try to move to the cell to the northeast (1 row up and 1 column right), wrapping around to the left and bottom when we reach the edge.
3. If that cell is occupied, move one 1 down (wrapping around to the top if we're on the bottom row) instead of moving to the northeast.

This is easy to do in Perl, and we don't even have to initialize the matrix.
```perl
my @m;
my $m = 3;
my $r = 0;
my $c = 1;

# fill in the magic square using the Siamese method
for my $i (1..9) {
    $m[$r][$c] = $i;
    my $r1 = ($r - 1) % $m;
    my $c1 = ($c + 1) % $m;
    if (defined $m[$r1][$c1]) {
        $r = ($r + 1) % $m;
    } else {
        $r = $r1;
        $c = $c1;
    }
}
```

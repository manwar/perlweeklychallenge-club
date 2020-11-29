Solutions by Walt Mankowski.

# Task #1: Array of Product

For this task we're given an array of positive integers `@n`. We need to create a new array `@m` where `$m[i]` is the product of all elements of `@n` except `$n[i]`.

This was easy to solve in Perl. First I initialized `@m` to be an array of all 1s of the same length as `@n`:
```perl
my @m = (1) x @n;
```
Then I just used 2 nested loops to compute the result:
```perl
for my $i (0..$#n) {
    for my $j (0..$#n) {
        $m[$j] *= $n[$i] unless $i == $j;
    }
}
```

# Task 2: Spiral Matrix

For this task we're given an m x n matrix of positive integers. We need to walk around the matrix in a spiral clockwise fashion, starting right across the top row, then down the last column, the left across the bottom row, etc., until we've visited every entry. We need to print out the values in the order we encounter them.

I used a number of state variables to solve this: the current row (`$r`), column (`$c`) and direction (`$dir`), which can be 'n', 's', 'e', or 'w'. The hash `%turn` shows what the new direction is every time we need to turn:
```perl
my %turn = (e => 's',
            s => 'w',
            w => 'n',
            n => 'e',
           );
```
`%dir` shows how the row and column should change each move for each direction:
```perl
my %dir = (e => [0,1],
           s => [1,0],
           w => [0,-1],
           n => [-1,0],
          );
```
Finally, `%seen` is used to keep track of which cells we've already visited. Its keys are "row,col"; for instance, when we've visited the cell at row=1, col=2, we will indicate this by setting `$seen{"1,2"} = 1;`.

Then we set our initial row and column to 0 and our direction to 'e', and start iterating, storing every value we see in `@res`. We turn when we would otherwise visit a cell we've already seen, or if we under- or overflow the grid. Since we're guaranteed to visit each cell once, we stop when the length of `@res` equals the area of the grid.
```perl
my @res;
my $r = 0;
my $c = 0;
my $dir = 'e';

while (@res < $rows * $cols) {
    push @res, $grid->[$r][$c];
    $seen{"$r,$c"} = 1;
    my $r1 = $r + $dir{$dir}->[0];
    my $c1 = $c + $dir{$dir}->[1];
    if ($r1 < 0 || $r1 >= $rows ||
        $c1 < 0 || $c1 >= $cols ||
        defined $seen{"$r1,$c1"}) {

        # turn and recalculate $r1 and $c1
        $dir = $turn{$dir};
        $r1 = $r + $dir{$dir}->[0];
        $c1 = $c + $dir{$dir}->[1];
    }
    ($r,$c) = ($r1,$c1);
}

say "@res";
```

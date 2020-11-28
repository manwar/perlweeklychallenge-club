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

# Task 2: Largest Rectangle

For this task we're given an m x n matrix containing only 0s and 1s. We need to find the largest rectangle containing only 1s and print it out, or print 0 if none was found. While the problem didn't explicitly state it, I assumed that a "rectangle" needs to have at least 2 rows and 2 columns.

I didn't do anything fancy here. I just wrote code to check all the possible rectangles in the matrix by brute force. I did this by iterating over each row `$row` and column $col, and then iterating over all the heights and widths where `($row, $col`) is the upper left corner.
```perl
# loop over all the possible rectangles looking for the best one
my $best_area = 0;
my $best_row;
my $best_col;
my $best_height;
my $best_width;
for my $row1 (0..$rows-2) {
    for my $col1 (0..$cols-2) {
        for my $row2 ($row1+1..$rows-1) {
            my $height = $row2 - $row1 + 1;
            for my $col2 ($col1+1..$cols-1) {
                my $width = $col2 - $col1 + 1;
                my $area = $width * $height;
                next if $area <= $best_area;

                if (all_ones($grid, $row1, $row2, $col1, $col2)) {
                    $best_area = $area;
                    $best_row = $row1;
                    $best_col = $col1;
                    $best_height = $height;
                    $best_width = $width;
                }
            }
        }
    }
}
```
The function `all_ones()` checks if a rectangle in the grid is all ones:
```perl
sub all_ones($grid, $row1, $row2, $col1, $col2) {
    for my $r ($row1..$row2) {
        for my $c ($col1..$col2) {
            return 0 if $grid->[$r][$c] == 0;
        }
    }

    return 1;
}
```
I thought about using an array slice to print out the largest rectangle, but that was going to be messy since Perl doesn't support 2-dimensional array slices. Then I realized that since I know the dimensions of the matrix, and since each value is 1, I could cheat and just have my code print out what it looks like!
```perl
if ($best_area == 0) {
    say 0;
} else {
    for my $r (1..$best_height) {
        say "1 " x $best_width;
    }
}
```

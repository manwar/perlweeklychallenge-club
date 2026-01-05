# Min Abs Diff Shift Grid. What??

**Challenge 354 solutions in Perl by Matthias Muth**

## Task 1: Min Abs Diff

> You are given an array of distinct integers.<br/>
> Write a script to find all pairs of elements with the minimum absolute difference.<br/>
> Rules (a,b):<br/>
> 1: a, b are from the given array.<br/>
> 2: a < b<br/>
> 3: b - a = min abs diff any two elements in the given array
>
> **Example 1**
>
> ```text
> Input: @ints= (4, 2, 1, 3)
> Output: [1, 2], [2, 3], [3, 4]
> ```
>
> **Example 2**
>
> ```text
> Input: @ints = (10, 100, 20, 30)
> Output: [10, 20], [20, 30]
> ```
>
> **Example 3**
>
> ```text
> Input: @ints = (-5, -2, 0, 3)
> Output: [-2, 0]
> ```
>
> **Example 4**
>
> ```text
> Input: @ints = (8, 1, 15, 3)
> Output: [1, 3]
> ```
>
> **Example 5**
>
> ```text
> Input: @ints = (12, 5, 9, 1, 15)
> Output: [9, 12], [12, 15]
> ```

It is not necessary to check *all* possible pairs in order to
get the minimal difference between any two numbers.
The minimal difference necessarily has to be between two numbers
that are next to each other when the numbers are sorted.
So I'm sorting the numbers first, and from the sorted numbers,
I directly build a list of pairs of neighboring numbers.

For conciseness, I use `slide` (from List::MoreUtils)
to walk through the sorted array to extract the pairs.
It comes in handy that `slide` assigns the two numbers
used in each iteration to the `$a` and `$b` special variables,
similar to the way `sort` does.

The pairs are then used for two things:
firstly, for finding the minimal difference of all pairs,
and secondly, for using the selection of pairs for the result list
that match the minimal difference.

```perl
use v5.36;
use List::Util qw( min );
use List::MoreUtils qw( slide );

sub min_abs_diff( @ints ) {
    my @pairs = slide { [ $a, $b ] } sort { $a <=> $b } @ints;
    my $min_diff = min( map $_->[1] - $_->[0], @pairs );
    return grep $_->[1] - $_->[0] == $min_diff, @pairs;
}
```

I have played around quite a bit with variations of this
to improve performance,
and I also ran some benchmarks using the various versions.

This here is what I call my 'Schwartzian' version,
because it reminds me of the
[Schwartzian transform](https://en.wikipedia.org/wiki/Schwartzian_transform),
a method of 'tunneling' data through a processing chain
that was invented by Randal L. Schwartz to improve sorting performance. 

The two numbers of each pair are put into small anonymous arrays,
together with their difference.
These triplets are passed through a `grep`
that uses the difference value to select the matching triplets only,
and a `map` call that extracts the number pair itself for the returned result:

```perl
# Schwartzian triplets
sub min_abs_diff_schw_3( $ints ) {
    $ints->@* > 1 or return ();
    my @sorted = sort { $a <=> $b } $ints->@*;
    my $min_diff = min( slide { $b - $a } @sorted );
    return
        map [ $_->@[1,2] ],
            grep $_->[0] == $min_diff,
                slide { [ $b - $a, $a, $b ] }
                    @sorted;
}
```

It actually is just a tiny little bit slower than the original version,
which is a pity, because I very much like the 'tunneling' idea.

I was astonished that my third version,
which introduces another array variable,
and which replaces the original's `map` call by another call to `slide`,
is actually faster.
Maybe it is because less array indexing has to be done
in the `slide` or `map` code block on the Perl level,
as it is done in the underlying C implementation of `slide`.

```perl
# Double use of 'slide'
sub min_abs_diff_2_slides( $ints ) {
    $ints->@* > 1 or return ();
    my @sorted = sort { $a <=> $b } $ints->@*;
    my @pairs = slide { [ $a, $b ] } @sorted;
    my @diffs = slide { $b - $a }    @sorted;
    my $min_diff = min( @diffs );
    return map $pairs[$_], grep $diffs[$_] == $min_diff, keys @pairs;
}
```

My search for performance was interesting,
but even if there are slight differences,
the three presented versions all play in the same league.

I was then blown away by the solution
[published by James Curtis-Smith](https://www.facebook.com/groups/perlcommunity/permalink/2128053411335607).
His version is more than 3 times as fast as any of my versions above.
I rewrote his solution to be a bit more readable
(basically only giving some useful names to variables),
and to find out why it is so fast:

```perl 
# James Curtis-Smith 1 Rewrite
sub min_abs_diff_jcs_rewrite( $ints ) {
    $ints->@* > 1 or return ();
    my ( $prev, @sorted, @results ) = sort  { $a <=> $b } $ints->@*;
    my $min = $sorted[0] - $prev;
    (
        ( $min > $_ - $prev )
        ? ( $min = $_ - $prev, @results = [ $prev, $_ ] )
        : ( ( $_ - $prev > $min ) || push @results, [ $prev, $_ ] ),
        $prev = $_
    ) for @sorted;
    return @results;
}
```

I think the reason is that apart from the `sort`,
which all of the solutions have in common,
James' solution only does *one* pass through the sorted data,
while all three of my solutions do two or three of them
(for the pairs, for the diffs, and for the comparison).

While rewriting his solution, I first used a `for ( ) { }` loop,
and normal, semicolon-separated statements within the loop body.
I did not manage to get the last few percentage points of performance
until I changed the `if ... elsif` chain
to the `:?` conditional expressions that James uses in his original solution,
and changed the `for ( ) { }` loop
into an appended `for LIST` statement modifier.
It seems that there is an overhead involved with at least one of the two.  

I have learned a lot!

## Task 2: Shift Grid

> You are given m x n matrix and an integer, \$k > 0.<br/>
> Write a script to shift the given matrix \$k times.<br/>
>
> ```text
> Each shift follow the rules:
> 
> Rule 1:
> Element at grid[i][j] moves to grid[i][j + 1]
> This means every element moves one step to the right within its row.
> 
> Rule 2:
> Element at grid[i][n - 1] moves to grid[i + 1][0]
> This handles the last column: elements in the last column of row i wrap to the first column of the next row (i+1).
> 
> Rule 3:
> Element at grid[m - 1][n - 1] moves to grid[0][0]
> This is the bottom-right corner: it wraps to the top-left corner.
> ```
> 
> **Example 1**
> ```text
> Input: @matrix = ([1, 2, 3],
>                      [4, 5, 6],
>                      [7, 8, 9],)
>           $k = 1
> Output: ([9, 1, 2],
>             [3, 4, 5],
>             [6, 7, 8],)
> 
> Rule 1: grid[i][j] -> grid[i][j+1] for j < n-1.
> We take elements from the original grid at (i, j) and put them into new_grid[i][j+1].
> From original:
> (0,0): 1 -> new_grid[0][1] = 1
> (0,1): 2 -> new_grid[0][2] = 2
> (1,0): 4 -> new_grid[1][1] = 4
> (1,1): 5 -> new_grid[1][2] = 5
> (2,0): 7 -> new_grid[2][1] = 7
> (2,1): 8 -> new_grid[2][2] = 8
> New grid looks after Rule 1:
> ([?, 1, 2],
>  [?, 4, 5],
>  [?, 7, 8],)
> 
> Rule 2: grid[i][n-1] -> grid[i+1][0] for i < m-1.
> Elements from original last column (except last row) go to next row's first column.
>  From original:
>  (0,2): 3 -> new_grid[1][0] = 3
> (1,2): 6 -> new_grid[2][0] = 6
> Now new grid after Rules 1 + 2:
> ([?, 1, 2],
>  [3, 4, 5],
>  [6, 7, 8],)
> 
> Rule 3: grid[m-1][n-1] -> grid[0][0].
> Original (2,2): 9 -> new_grid[0][0] = 9.
> Now new_grid is complete:
> ([9, 1, 2],
>  [3, 4, 5],
>  [6, 7, 8],)
> ```
>  
>  **Example 2**
> 
> ```text
> Input: @matrix = ([10, 20],
>                   [30, 40],)
>        $k = 1
> Output: ([40, 10],
>          [20, 30],)
> 
>  Rule 1 (move right in same row if not last column):
>  (0,0): 10 -> new[0][1] = 10
> (1,0): 30 -> new[1][1] = 30
>After Rule 1:
> ([?, 10],
> [?, 30],)
> 
> Rule 2 (last col -> next row’s first col, except last row):
>    (0,1): 20 -> new[1][0] = 20
>    After Rule 2:
> ([?,  10],
>     [20, 30],)
> 
> Rule 3 (bottom-right to top-left):
> (1,1): 40 -> new[0][0] = 40
> After Rule 3:
> ([40, 10],
>  [20, 30],)
> ```
> 
> **Example 3**
>  
> ```text
> Input: @matrix = ([1, 2],
>                   [3, 4],
>                   [5, 6],)
>        $k = 1
> Output: ([6, 1],
>          [2, 3],
>          [4, 5],)
>  
> Rule 1:
> (0,0): 1 -> new[0][1] = 1
> (1,0): 3 -> new[1][1] = 3
> (2,0): 5 -> new[2][1] = 5
> After Rule 1:
> ( [?, 1],
>  [?, 3],
>  [?, 5],)
>  
> Rule 2:
>(0,1): 2 -> new[1][0] = 2
> (1,1): 4 -> new[2][0] = 4
>After Rule 2:
> ([?, 1],
>  [2, 3],
>     [4, 5],)
>    
>    Rule 3:
> (2,1): 6 -> new[0][0] = 6
>    After Rule 3:
>    ([6, 1],
>  [2, 3],
>  [4, 5],)
> ```
> 
> **Example 4**
> 
> ```text
> Input: @matrix = ([1, 2, 3],
>                     [4, 5, 6],)
>          $k = 5
> Output: ([2, 3, 4],
>          [5, 6, 1],)
> 
> Shift 1
> 
> Rule 1
> 1 -> (0,1)
>  2 -> (0,2)
>  4 -> (1,1)
> 5 -> (1,2)
> 
> Rule 2
> 3 -> (1,0) (last column of row 0)
> 
> Rule 3
>  6 -> (0,0) (bottom-right corner)
>  
> Result
>[6, 1, 2]
> [3, 4, 5]
>
> ----------------------------
> Shift 2
>    Starting from the previous matrix:
>    [6, 1, 2]
> [3, 4, 5]
>    
> Rule 1
> 6 -> (0,1)
> 1 -> (0,2)
> 3 -> (1,1)
> 4 -> (1,2)
> 
> Rule 2
> 2 -> (1,0)
> 
> Rule 3
> 5 -> (0,0)
> 
> Result
> [5, 6, 1]
> [2, 3, 4]
> 
> ----------------------------
> Shift 3
> [5, 6, 1]
> [2, 3, 4]
> 
> Rule 2: 1 -> (1,0)
> Rule 3: 4 -> (0,0)
> 
> Others follow Rule 1
> 
> Result
> [4, 5, 6]
> [1, 2, 3]
> 
> ----------------------------
> Shift 4
> [4, 5, 6]
> [1, 2, 3]
> 
> Result
> [3, 4, 5]
> [6, 1, 2]
> 
> ----------------------------
> Shift 5
> [3, 4, 5]
> [6, 1, 2]
> 
> Result
> [2, 3, 4]
> [5, 6, 1]
> 
> Final Output (after k = 5 shifts)
> ([2, 3, 4],
>  [5, 6, 1])
> ```
> 
> **Example 5**
> 
> ```text
> Input: @matrix = ([1, 2, 3, 4])
>        $k = 1
> Output: ([4, 1, 2, 3])
> 
> Rule 1:
> (0,0): 1 -> new[0][1] = 1
> (0,1): 2 -> new[0][2] = 2
> (0,2): 3 -> new[0][3] = 3
> After Rule 1:
> ([?, 1, 2, 3])
> 
> Rule 2:
> (0,3): 4 -> new[1][0] ??
> Wait - but i=0, n-1=3, next row i+1=1 doesn’t exist (m=1).
> So this is actually a special case where Rule 2 should not apply.
> because m=1, so (0,3) goes by Rule 3 actually.
> 
> The rules say:
> grid[i][j]     -> grid[i][j+1] for j < n-1.
> grid[i][n-1]   -> grid[i+1][0] for i < m-1.
> grid[m-1][n-1] -> grid[0][0].
> 
> For m = 1:
> Elements (0,0),(0,1),(0,2) follow Rule 1 -> (0,1),(0,2),(0,3).
> Element (0,3) is (m-1, n-1), so follows Rule 3 -> (0,0).
> 
> Actually, that means after Rule 1:
>  We put 1,2,3 in positions 1,2,3, leaving position 0 empty.
> Then Rule 3 puts 4 in position 0.
>
> So final directly:
>[4, 1, 2, 3]
> ```

I think the most important design decision
is *not* to do all the operations one by one as the rules would suggest,
but to simplify the round shift operation:

- Flatten the matrix into one large, one-dimensional array.<br/>
  This doesn't need a library call.
  As the rows are actually arrayrefs,
  mapping each row arrayref into its elements is all we need: 

  ```perl
      my @array = map $_->@*, $matrix->@*;
  ```

- Shift the whole array by `$k` places,
  by removing `$k` elements at its end
  (those elements that are 'shifted out'),
  and reinserting them at the beginning of the array.<br/>
  Take care of cases where `$k` is greater than the array length,
  by using `$k % <array_length>` instead of just `$k`.

  ```perl
      unshift @array, splice( @array, -( $k % @array ) );
  ```

  `splice` removes `( $k % @array )` elements from the end of the string,
  and `unshift` does the reinsertion at the beginning.

- Extract elements from the resulting array row by row,
  creating a new array of the same size as the original one.<br/>
  In this implementation, I use an index variable `$i`
  to point to the next row of elements in the array,
  and a variable `$w` to contain the row length,
  determined from the length of the first row in the original matrix.<br/>
  To make things easier to write,
  in each iteration I first increment the index variable,
  then extract the row data by 'looking backwards' from the new index value:

  ```perl
      my ( $i, $w ) = ( 0, scalar $matrix->[0]->@* );
      return map { $i += $w; [ @array[ $i - $w .. $i - 1 ] ] } keys $matrix->@*;
  ```

So my complete solution looks like this:

```perl
use v5.36;

sub shift_grid( $matrix, $k ) {
    my @array = map $_->@*, $matrix->@*;
    unshift @array, splice( @array, @array - $k % @array );
    my ( $i, $w ) = ( 0, scalar $matrix->[0]->@* );
    return map { $i += $w; [ @array[ $i - $w .. $i - 1 ] ] } keys $matrix->@*;
}
```

#### **Thank you for the challenge!**

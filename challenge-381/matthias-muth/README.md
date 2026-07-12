# Smaller? Greater? Same!
**Challenge 381 solutions in Perl by Matthias Muth**

## Task 1: Same Row Column

> You are given a n x n matrix containing integers from 1 to n.<br/>
> Write a script to find if every row and every column contains all the integers from 1 to n.
>
> **Example 1**
>
> ```text
> Input: @matrix = ([1, 2, 3, 4],
>                   [2, 3, 4, 1],
>                   [3, 4, 1, 2],
>                   [4, 1, 2, 3],)
> Output: true
> ```
>
> **Example 2**
>
> ```text
> Input: @matrix = ([1])
> Output: true
> ```
>
> **Example 3**
>
> ```text
> Input: @matrix = ([1, 2, 5],
>                   [5, 1, 2],
>                   [2, 5, 1],)
> Output: false
>
> Elements are out of range 1..3.
> ```
>
> **Example 4**
>
> ```text
> Input: @matrix = ([1, 2, 3],
>                   [1, 2, 3],
>                   [1, 2, 3],)
> Output: false
> ```
>
> **Example 5**
>
> ```text
> Input: @matrix = ([1, 2, 3],
>                   [3, 1, 2],
>                   [3, 2, 1],)
> Output: false
> ```

Only integers from $1$ to $n$ are allowed, so we can exit the subroutine immediately with a `false` value when we encounter a matrix value outside this range.

But knowing that we need all values from $1$ to $n$ in each row and each column, we can mark the presence of every matrix value at ( $r$, $c$ ) in a 'presence array' for row $r$ and another one for column $c$. In the end, all those arrays need to have all values from $1$ to $n$. More importantly for us, there cannot be any duplicates. This means that whenever a value already has been marked as present in the same row or the same column, we can exit with a `false` value, too. 

The 'presence arrays' are grouped in two matrices `@row_presences` and `@column_presences`, and everything is done in two nested loops for the rows and the columns.

```perl
use v5.36;
use builtin qw( true false );
no warnings 'experimental::builtin';

sub same_row_column( $matrix ) {
    my $n = scalar $matrix->@*;
    my ( @row_presences, @column_presences );
    for my $r ( keys $matrix->@* ) {
        for my $c ( keys $matrix->[$r]->@* ) {
            my $value = $matrix->[$r][$c];
            return false
                unless 0 < $value <= $n
                    && ! $row_presences[$r][$value]++
                    && ! $column_presences[$c][$value]++
        }
    }
    return true;
}
```

## Task 2: Smaller Greater Element

> You are given an array of integers.<br/>
> Write a script to find the number of elements that have both a strictly smaller and greater element in the given array.
>
> **Example 1**
>
> ```text
> Input: @int = (2,4)
> Output: 0
>
> Not enough elements in the array.
> ```
>
> **Example 2**
>
> ```text
> Input: @int = (1, 1, 1, 1)
> Output: 0
> ```
>
> **Example 3**
>
> ```text
> Input: @int = (1, 1, 4, 8, 12, 12)
> Output: 2
>
> The elements are 4 and 8.
> ```
>
> **Example 4**
>
> ```text
> Input: @int = (3, 6, 6, 9)
> Output: 2
>
> Both instances of 6.
> ```
>
> **Example 5**
>
> ```text
> Input: @int = (0, -5, 10, -2, 4)
> Output: 3
>
> The elements are 0, -2, and 4.
> ```

The only numbers in the array that *don't* have 'both a strictly smaller and greater element in the given array' are the smallest and the largest number in the array. 

This means we need to find the minimum and the maximum values in the array. While going through the array, we can also count how many times each number occurs i.e. its frequency. This is because we need to know how many array elements do not meet the criteria. In other words, we need to know how many times the smallest and the largest numbers occur.

If we don't have at least two distinct numbers (the smallest one and the largest one), there can't be any numbers in between that fulfill the criteria, so we return `0`. If there are, we deduct the number of occurrences of the smallest and the largest number from the total number of values in the array, and that's it.  

```perl
use v5.36;

sub smaller_greater_element( @int ) {
    my ( $min, $max, %freq ) = ( $int[0], $int[0] );
    for ( @int ) {
        $max >= $_ or $max = $_;
        $min <= $_ or $min = $_;
        ++$freq{$_};
    }
    return
        scalar %freq <= 2
        ? 0
        : @int - $freq{$min} - $freq{$max};
}
```

#### **Thank you for the challenge!**

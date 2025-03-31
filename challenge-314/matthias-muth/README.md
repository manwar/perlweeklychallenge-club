# Count Any Zipped Column

**Challenge 314 solutions in Perl by Matthias Muth**

## Task 1: Equal Strings

> You are given three strings.<br/>
> You are allowed to remove the rightmost character of a string to make all equals.<br/>
> Write a script to return the number of operations to make it equal otherwise -1.
>
> **Example 1**
>
> ```text
> Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
> Output: 2
>
> Operation 1: Delete "c" from the string "abc"
> Operation 2: Delete "b" from the string "abb"
> ```
>
> **Example 2**
>
> ```text
> Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
> Output: -1
> ```
>
> **Example 3**
>
> ```text
> Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
> Output: 3
> ```

We are supposed to make the three strings equal by *removing* unequal characters from the right.

But that's the same as *keeping* characters from the *left* of the strings, as long as all three of them are equal. So we might as well count the characters that are the same, and then just cut off the rests.<br/>
Let's do that counting:

```perl
    my $n_equal = 0;
    ++$n_equal
        while $n_equal < length( $s1 )
            && substr( $s2, $n_equal, 1 ) eq substr( $s1, $n_equal, 1 )
            && substr( $s3, $n_equal, 1 ) eq substr( $s1, $n_equal, 1 );
```

We use the first string to lead the operation. We first check whether its length still gives us another character to compare. If not, there can't be any more equal characters, and we exit the loop.

If we do have another character from `$s1`, we compare it to the characters from `$s2` and `$s3` at the same index. We make use of the 'friendly behavior' of the `substr` function to return an empty string for the index right after the end of the string. So if one of those other two strings is exhausted, we will compare to an empty string, and of course it won't match. This will end the loop, too.

When we have found the number of equal characters, we can return the result.<br/>But first, we return a `-1` if no characters match at all, as requested:

```perl
    return -1
        if $n_equal == 0;
```

Good that we don't really have to manipulate the strings, but only return the number of characters to cut off.

For every string, we cut of the characters *after* the equal characters. We can use `map` to get the number of characters to cut off for all three strings (which is the difference between the `$n_equal` and the length of each string), and we can sum up those numbers at the same time:

```perl
    return sum( map length( $_ ) - $n_equal, $s1, $s2, $s3 );
```

That gives us this as the complete solution:

```perl
use v5.36;
use List::Util qw( sum );

sub equal_strings( $s1, $s2, $s3 ) {
    my $n_equal = 0;
    ++$n_equal
        while $n_equal < length( $s1 )
            && substr( $s2, $n_equal, 1 ) eq substr( $s1, $n_equal, 1 )
            && substr( $s3, $n_equal, 1 ) eq substr( $s1, $n_equal, 1 );
    return -1
        if $n_equal == 0;
    return sum( map length( $_ ) - $n_equal, $s1, $s2, $s3 );
}
```



## Task 2: Sort Column

> You are given a list of strings of same length.<br/>
> Write a script to make each column sorted lexicographically by deleting any non sorted columns.<br/>
> Return the total columns deleted.
>
> **Example 1**
>
> ```text
> Input: @list = ("swpc", "tyad", "azbe")
> Output: 2
>
> swpc
> tyad
> azbe
>
> Column 1: "s", "t", "a" => non sorted
> Column 2: "w", "y", "z" => sorted
> Column 3: "p", "a", "b" => non sorted
> Column 4: "c", "d", "e" => sorted
>
> Total columns to delete to make it sorted lexicographically.
> ```
>
> **Example 2**
>
> ```text
> Input: @list = ("cba", "daf", "ghi")
> Output: 1
> ```
>
> **Example 3**
>
> ```text
> Input: @list = ("a", "b", "c")
> Output: 0
> ```

This task consists of several 'complications'. The first one is to extract columns from the strings.

I have recently learned how easy it is to flip matrices using the `zip` function (from the `List::Util` core module).<br/>Here, we first split the strings into a list of (anonymous) arrays of characters to form the 'rows' of the matrix.<br/>
Then: `zip` to flip them into columns.<br/>Here we go:

```perl
    my @columns = zip map [ split "", $_ ], @list;
```

The 'columns' are now available as anonymous arrays, and `@columns` contains the array-refs to those arrays.

The second 'complication' is to check whether a column is sorted or not.<br/>When an array is sorted, every character is alphanumerically greater or equal than its predecessor.<br/>If we want to check whether the column is *non*-sorted, we can check whether we find any character that is alphanumerically *less* than its predecessor. This translates well into a call to `any` (also from `List::Util`) . With `$column` being the array-ref to the column values, it looks like this (note the index starting at `1`!):

```perl
        any { $column->[$_] le $column->[$_-1] } 1..$column->$#*;
```

We can use this in a `grep` call to go through all columns, and as `grep` returns the number of matches (not the matches themselves) when it is used in scalar context, we also have a convenient way to sum up the number of the non-sorted columns found:

```perl
    return scalar grep {
        my $column = $_;
        any { $column->[$_] le $column->[$_-1] } 1..$column->$#*;
    } @columns;
```

So even with several 'complications', the complete solution doesn't have to be too complicated:

```perl
use v5.36;
use List::Util qw( zip any );

sub sort_column( @list ) {
    my @columns = zip map [ split "", $_ ], @list;
    return scalar grep {
        my $column = $_;
        any { $column->[$_] le $column->[ $_ - 1 ] } 1..$column->$#*;
    } @columns;
}
```



#### **Thank you for the challenge!**

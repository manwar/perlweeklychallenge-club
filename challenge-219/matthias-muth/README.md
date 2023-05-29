# Highscore!
**Challenge 218 solutions in Perl by Matthias Muth**

## Task 1: Maximum Product

> You are given a list of 3 or more integers.<br/>
> Write a script to find the 3 integers whose product is the maximum and return it.<br/>

If we have exactly three numbers, there's not a lot of choice.<br/>
We return the product of the three numbers that we have got:
```perl
    use List::Util qw( product );

    return product( @list )
        if @list == 3;
```

We need to consider that we might have negative numbers in the list,
and there might be situations where we cannot avoid ending up with a negative product.
But, of course, *any* positive product is better that *any* negative one!<br/>
So we first try to find the largest possible *positive* product using three numbers from the list.<br/>

The largest positive productmy be wither of these:
* the product of the three largest positive numbers,
* the product of the two negatives with the highest absolute value, and the largest positive number<br/>
(the two negatives turning the result into positive).

We cannot say in advance which of these will be better,
because this depends on the absolute values of the positive and negative 'best' numbers,
So, after splitting up our list into positives and negatives,
sorted by highest to lowest absolute values,
we compute them both (if possible), 
and then return the better one, if at lest one of them could be produced:

```perl
    my @pos = sort { abs( $b ) <=> abs( $a ) } grep $_ > 0, @list;
    my @neg = sort { abs( $b ) <=> abs( $a ) } grep $_ < 0, @list;

    my @positive_results = (
        @pos >= 3              ? product( @pos[0..2] )          : (),
        @pos >= 1 && @neg >= 2 ? product( @neg[0..1], $pos[0] ) : (),
    );

    # If we have at least one of them, we are done.
    return max( @positive_results )
        if @positive_results;
```

If it was not possible to return a positive result,
we should at least try to limit our outcome to zero.<br/>
We can return a zero result if we have at least one zero in the list,
because no matter which other numbers we multiply it with, it still remains a zero:

```perl
    return 0
        if grep $_ == 0, @list;
```

If this didn't work either, we are set to return a negative result.

At this point we are sure that we have at least three negative numbers,
because we know that
* we have at least 4 numbers in total<br/>
  (because there are >= 3 by definition, and we checked for having exactly three already),
* we have at most 2 positives<br/>
  (because we ruled out having 3 positives),
* we don't have any zeroes<br/>,
  (we just checked).

So we have at least 2 negatives.<br/>
From that we can follow that
* we don't even have 1 positive
  (because we would have combined it with the two negatives for a positive result).

So actually we have *only* negative numbers, and at least 4 of them.

We choose the ones with the lowest absolute value, giving us the highest
(least negative) result possible.<br/>
To get those, we just reverse the list that we already have,
which is equivalent to sorting then into ascending order, 
and then take the first three entries.
```perl
    return product( ( reverse @neg )[0..2] );
```
And we are done.

## Task 2: Matrix Score

> You are given a m x n binary matrix i.e. having only 1 and 0.<br/>
> You are allowed to make as many moves as you want to get the highest score.<br/>
> A move can be either toggling each value in a row or column.<br/>
> To get the score, convert the each row binary to dec and return the sum.<br/>

So we want to get a final sum that is as high as possible.<br/>
Then let's have a look at what makes up that sum:

In the binary matrix like in Example 1,
```
  [ 0 0 1 1 ]
  [ 1 0 1 0 ]
  [ 1 1 0 0 ]
```
we will convert the rows from binary to decimal.<br/>
This means that every bit will be multiplied by a 2<sup>n</sup> value:
```
  [ 8 4 2 1 ]
```

To get as high as possible a sum, all the bits with a value of `8` should be set to `1`.
No matter what the other bits in the same row are,
a value of `8` is more than all the other bits can achieve together (a maximum of 7).

So in the first step, we flip all rows that have a `0` in the first position:
```perl
    for my $row ( grep $_->[0] == 0, @$matrix ) {
        $row->[$_] ^= 1
            for 0..$#$row;
    }
```

In the second step, we go through all columns but the first one,
and flip all those that have less `1`s that `0`s.<br/>
This maximizes the sum of values that we get from each column.
```perl
    my $n_columns = scalar @{$matrix->[0]};
    for my $c ( 1 .. $n_columns - 1 ) {
        # Sum up that column's value from every row.
        my $column_sum = sum( map $_->[$c], @$matrix );
        if ( $column_sum < $n_columns / 2 ) {
            # Flip that column in every row.
            $_->[$c] ^= 1
                for @$matrix;
        }
    }
```

This should give us a good matrix.

Now we need to return the sum of all rows converted from binary to decimal.<br/>
It requires a little thinking how to do this nicely, without doing all the for-loops
and all the multiplication with the 2<sup>n</sup> values, but everything is already there in perl!

My solution for the conversion of one row is this one:<br/>
Looking for a `pack` format that makes the conversion easy,
I choose the 'b32' format to get 4 bytes of data from a maximum of 32 column values.<br/>
This format uses the least significant bit first, and assumes `0` bits when it runs out of values.
This is good, because we don't need do anything to fill up our data to any word boundaries.<br/>
We just need to `reverse` our bit array to have the least significant value first,
and to turn it into a string `0` or `1` characters for each bit value, before passing it to `pack`.

The resulting `pack` output byte-string matches this description:
> An unsigned long (32-bit) in "VAX" (little-endian) order.

which means that we can `unpack` it into a numerical value using `unpack`'s `V` format.<br/>
So my function to turn a list of binary values into a decimal value is this:
```perl
sub binary_list_to_integer {
    return unpack( "V", pack( "b32", join( "", reverse @_ ) ) );
}
```

And using that function we return the 'matrix score' end result like this:
```perl
    return sum( map binary_list_to_integer( @$_ ), @$matrix );
```

**Thank you for the challenge!**
  

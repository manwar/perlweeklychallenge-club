# Consecutive, but Maybe Not Final

**Challenge 325 solutions in Perl by Matthias Muth**

## Task 1: Consecutive One

> You are given a binary array containing only 0 or/and 1.<br/>
> Write a script to find out the maximum consecutive 1 in the given array.
>
> **Example 1**
>
> ```text
> Input: @binary = (0, 1, 1, 0, 1, 1, 1)
> Output: 3
>```
> 
>**Example 2**
> 
>```text
> Input: @binary = (0, 0, 0, 0)
> Output: 0
> ```
>
> **Example 3**
>
> ```text
>Input: @binary = (1, 0, 1, 0, 1, 1)
> Output: 2
> ```

For this task, first thing I do is to walk through the array and assign to each element the number of `1`s that have been seen since the last `0`. Like this:

```text
@binary:        0       1       1       0       1       1       1
                |       |       |       |       |       |       |
# of ones:      0       1       2       0       1       2       3
```

To do that, I need to carry over the current number of `1`s from position to position. This makes it a perfect use case for the `reductions` function (from `List::Util`). In its code block, the `$a` variable is the result for the previous element, and `$b` is the current element. That makes this type of 'conditional counting' very easy:

 ```perl
     reductions { $b ? ++$a : 0 } @binary
 ```

Now it's very simple to find the maximum number of consecutive `1`s: just apply the `max` function on the result.

Which makes this tasks solution a very nice and simple one-line-of-code function:  

```perl
sub consecutive_one( @binary ) {
    return max( reductions { $b ? ++$a : 0 } @binary );
}
```

## Task 2: Final Price

> You are given an array of item prices.<br/>
> Write a script to find out the final price of each items in the given array.<br/>
> There is a special discount scheme going on. If there’s an item with a lower or equal price later in the list, you get a discount equal to that later price (the first one you find in order).
>
> **Example 1**
>
> ```text
> Input: @prices = (8, 4, 6, 2, 3)
> Output: (4, 2, 4, 2, 3)
>
> Item 0:
> The item price is 8.
> The first time that has price <= current item price is 4.
> Final price = 8 - 4 => 4
>
> Item 1:
> The item price is 4.
> The first time that has price <= current item price is 2.
> Final price = 4 - 2 => 2
>
> Item 2:
> The item price is 6.
> The first time that has price <= current item price is 2.
> Final price = 6 - 2 => 4
>
> Item 3:
> The item price is 2.
> No item has price <= current item price, no discount.
> Final price = 2
>
> Item 4:
> The item price is 3.
> Since it is the last item, so no discount.
> Final price = 3
>```
> 
>**Example 2**
> 
>```text
> Input: @prices = (1, 2, 3, 4, 5)
> Output: (1, 2, 3, 4, 5)
> ```
>
> **Example 3**
>
> ```text
>Input: @prices = (7, 1, 1, 5)
> Output: (6, 0, 1, 5)
> 
> Item 0:
>The item price is 7.
> The first time that has price <= current item price is 1.
> Final price = 7 - 1 => 6
> 
> Item 1:
>The item price is 1.
> The first time that has price <= current item price is 1.
> Final price = 1 - 1 => 0
> 
> Item 2:
>The item price is 1.
> No item has price <= current item price, so no discount.
> Final price = 1
> 
> Item 3:
>The item price is 5.
> Since it is the last item, so no discount.
> Final price = 5
> ```

My solution for this task is short , and simple enough, but I don't really like it.<br/>
I couldn't come up with a way to avoid the 'almost quadratic' behavior of walking through the whole rest of the list to find a discount for *every* entry in the list, that's why I am not really happy.

But this is what I have:

I use `map` to map the item prices from the `@prices` array to the final prices to be returned. The final price is the item price minus a possible discount, and for getting that discount, I use `first` to walk through the rest of the array to find the next item price that is lower than or equal to the current one.

```perl
use v5.36;
use List::Util qw( first );

sub final_price( @prices ) {
    return map {
        my $price = $prices[$_];
        my $discount = first { $_ <= $price } @prices[ $_ + 1 .. $#prices ];
        $price - ( $discount // 0 );
    } keys @prices;
}
```

As I said, simple enough, but I guess there must be a better algorithmic solution ...

#### **Thank you for the challenge!**

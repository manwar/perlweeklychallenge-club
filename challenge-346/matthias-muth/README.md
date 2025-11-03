# Visiting the Peaks

**Challenge 345 solutions in Perl by Matthias Muth**

## Task 1: Peak Positions

> You are given an array of integers, @ints.<br/>
> Find all the peaks in the array, a peak is an element that is strictly greater than its left and right neighbours. Return the indices of all such peak positions.
>
> **Example 1**
>
> ```text
> Input: @ints = (1, 3, 2)
> Output: (1)
> ```
>
> **Example 2**
>
> ```text
> Input: @ints = (2, 4, 6, 5, 3)
> Output: (2)
> ```
>
> **Example 3**
>
> ```text
> Input: @ints = (1, 2, 3, 2, 4, 1)
> Output: (2, 4)
> ```
>
> **Example 4**
>
> ```text
> Input: @ints = (5, 3, 1)
> Output: (0)
> ```
>
> **Example 5**
>
> ```text
> Input: @ints = (1, 5, 1, 5, 1, 5, 1)
> Output: (1, 3, 5)
> ```

I conclude from Example 4 that the first position in the array can be a 'peak' even if it doesn't strictly have a 'left and right neighbour' (it only has a right one). I assume that the last element can therefore be a 'peak' as well.

To simplify the comparisons and avoid checking for the left and right edge for every possible 'peak', I make a copy of the array, adding a zero at each end. We are looking for 'peaks' in our landscape of numbers, so I call this new array the `@ridge`.

I then make use Perl's ability to perform *chained comparisons*:<br/>
Checking whether an element's left neighbour is *strictly smaller than* (`<`) the element, and the element itself is *strictly larger than* (`>`) its right neighbour can be done in a single expression, because the two comparison operators have the same operator precedence (minding that `==` has a lower one, so it can not be be chained with `<` or `>`).

It looks a bit unusual because most of the times, the comparisons are in the same direction (like `$a <= $_ <= $b`), but it works perfectly. 

*Chained comparison*s were introduced in Perl 5.32. To reflect that fact, I changed my standard boilerplate (which is `use v5.36`,  for getting *strict* and *warnings* and subroutine signatures).

Note that in each iteration, we are testing  `$ridge[ $_ + 1 ]` to be a peak, but it is correct to return `$_` as its position `$_` is the peak's index in the original `@ints` array.

This is my whole solution:

```perl
use v5.32;      # For chained comparisons.
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

sub peak_positions( @ints ) {
    my @ridge = ( 0, @ints, 0 );
    return grep $ridge[$_] < $ridge[ $_ + 1 ] > $ridge[ $_ + 2 ], keys @ints;
}
```

## Task 2: Last Visitor

> You are given an integer array @ints where each element is either a positive integer or -1.<br/>
> We process the array from left to right while maintaining two lists:
> ```
> @seen: stores previously seen positive integers (newest at the front)
> @ans: stores the answers for each -1
> ```
> Rules:
> ```text
> If \$ints[i] is a positive number -> insert it at the front of @seen<br/>
> If \$ints[i] is -1:<br/>
> ```
>
> Let \$x be how many -1s in a row we’ve seen before this one.<br/>
> If \$x < len(@seen) -> append seen[x] to @ans<br/>
> Else -> append -1 to @ans<br/>
> At the end, return @ans.
>
> **Example 1**
>
> ```text
> Input: @ints = (5, -1, -1)
> Output: (5, -1)
>
> @seen = (5)
> First  -1: @ans = (5)
> Second -1: @ans = (5, -1)
> ```
>
> **Example 2**
>
> ```text
> Input: @ints = (3, 7, -1, -1, -1)
> Output: (7, 3, -1)
>
> @seen = (3, 7)
> First  -1: @ans = (7)
> Second -1: @ans = (7, 3)
> Third  -1: @ans = (7, 3, -1)
> ```
>
> **Example 3**
>
> ```text
> Input: @ints = (2, -1, 4, -1, -1)
> Output: (2, 4, 2)
> ```
>
> **Example 4**
>
> ```text
> Input: @ints = (10, 20, -1, 30, -1, -1)
> Output: (20, 30, 20)
> ```
>
> **Example 5**
>
> ```text
> Input: @ints = (-1, -1, 5, -1)
> Output: (-1, -1, 5)
> ```

For this task, I have condensed my code a bit, Perl style. Actually there only is one declaration and one statement. This means that I make more use of implicit behaviors. Let's see whether I can find and explain them all.

The declaration is for the `@seen` array, exactly as the task description says, and for `$count`, which is the variable that counts how many `-1`s have been seen in a row (called `$x` in the task description, but I prefer a more telling name).<br>Actually I initialize `$count` with `0` explicitly, even though this is not really needed. The only operation on this variable is an auto-increment, and that operation's little magic works without warning even if the variable is undefined.

Instead of writing a `for` loop and pushing values to an `@ans` array within the loop, I let `map`do the processing. The result of `map` can be returned directly, so in fact there is no need for the `@ans` array to even exist.

Within `map`'s code block, if the number that is processed is `-1`, we generate a value for the result list.<br/>
No need to check whether '\$x < len(@seen)' (or, in Perl: `$count <= $#seen`), because if `$count` points to an element beyond the current length of the `@seen` array, Perl just returns `undef`, and we can use the `//` *defined or* operator to get the appropriate value for that case (which is `-1`).

Another trick is that as the list generated by `map` consists of the collection of zero, one, or more elements from each evaluation of the code block, in our case, if the input number is *not* `-1`, the code block can perform some necessary processing, but then evaluate to an empty list to be added to the result.<br/>
The 'necessary processing' in our case involves pushing the value to the `@seen` array and resetting the `$count` to `0`.<br/>
Mixing code execution and data generation in this way is easy in Perl and helps create concise programs, even though it may sometimes require a second look.

But maybe it's still easy enough to read the code itself:

```perl
use v5.36;

sub last_visitor( @ints ) {
    my ( $count, @seen ) = ( 0 );
    return map {
        $_ == -1
        ? $seen[$count++] // -1
        : do { unshift @seen, $_; $count = 0; () }
    } @ints;
}
```

#### **Thank you for the challenge!**

# Distinctive Overlaps

**Challenge 321 solutions in Perl by Matthias Muth**

## Task 1: Distinct Average

> You are given an array of numbers with even length.<br/>
> Write a script to return the count of distinct average. The average is calculate by removing the minimum and the maximum, then average of the two.
>
> **Example 1**
>
> ```text
> Input: @nums = (1, 2, 4, 3, 5, 6)
> Output: 1
>
> Step 1: Min = 1, Max = 6, Avg = 3.5
> Step 2: Min = 2, Max = 5, Avg = 3.5
> Step 3: Min = 3, Max = 4, Avg = 3.5
>
> The count of distinct average is 1.
>```
> 
>**Example 2**
> 
>```text
> Input: @nums = (0, 2, 4, 8, 3, 5)
> Output: 2
> 
>Step 1: Min = 0, Max = 8, Avg = 4
> Step 2: Min = 2, Max = 5, Avg = 3.5
> Step 3: Min = 3, Max = 4, Avg = 3.5
> 
>The count of distinct average is 2.
> ```
>
> **Example 3**
>
> ```text
>Input: @nums = (7, 3, 1, 0, 5, 9)
> Output: 2
> 
> Step 1: Min = 0, Max = 9, Avg = 4.5
>Step 2: Min = 1, Max = 7, Avg = 4
> Step 3: Min = 3, Max = 5, Avg = 4
> 
> The count of distinct average is 2.
>```

We need to get the minimum and the maximum of the entries in the `@nums` array, and we have to do that repeatedly.

I think that the easiest way to do this is to first sort the array numerically:

```perl
    @nums = sort { $a <=> $b } @nums;
```

Then, we have the minimum in the first entry
and the maximum in the last one.<br/>
It's easy to get and remove those two from the array at the same time:
we can use `shift` to get and remove the first one (the minimum),
and `pop` to do the same for the last one (the maximum).<br/>
So the average is this: 

```perl
    ( shift( @nums ) + pop( @nums ) ) / 2
```

We will be doing this in a loop,
as long as we still have at least two numbers
(for calculating their average) in the array.

But how do we count the *distinct* averages?

Someone
[said](https://perldoc.perl.org/perlfaq4#How-can-I-remove-duplicate-elements-from-a-list-or-array?)
'When you think the words "unique" or "duplicated", think "hash keys"'.<br/>
"Unique" and "distinct" are very often used interchangeably,
even though they don't mean exactly the same thing.<br/>
But no matter what,
a hash helps us to find the number of *distinct* values of averages:<br/>
Whenever we have computed an average value,
we create a hash entry with that value as a key,
for example by assigning a value of `1` to it:

```perl
    my %distinct_values;
    while ( @nums >= 2 ) {
        $distinct_values{ ( shift( @nums ) + pop @nums ) / 2 } = 1;
    }
```

When we are done,
the number of keys in the hash is the number of distinct values we are looking for.
We can get the number of keys by using the hash in scalar context.

Which makes this my solution:

```perl
use v5.36;

sub distinct_average( @nums ) {
    @nums = sort { $a <=> $b } @nums;
    my %distinct_values;
    while ( @nums >= 2 ) {
        $distinct_values{ ( shift( @nums ) + pop @nums ) / 2 } = 1;
    }
    return scalar %distinct_values;
}
```

## Task 2: Backspace Compare

> You are given two strings containing zero or more #.<br/>
> Write a script to return true if the two given strings are same by treating # as backspace.
>
> **Example 1**
>
> ```text
> Input: $str1 = "ab#c"
>        $str2 = "ad#c"
> Output: true
>
> For first string,  we remove "b" as it is followed by "#".
> For second string, we remove "d" as it is followed by "#".
> In the end both strings became the same.
>```
> 
>**Example 2**
> 
>```text
> Input: $str1 = "ab##"
>     $str2 = "a#b#"
>    Output: true
> ```
>
> **Example 3**
>
> ```text
>Input: $str1 = "a#b"
>     $str2 = "c"
> Output: false
>    ```

Tricky!

Treating the `#` character as 'backspace' means that the character preceding the `#` as well as the `#` itself can be removed from the string.

My first solution,
just doing a global regex substitution (`s/.\#//g`) for both strings,
did not work.<br/>
The reason is in Example 2 (`"ab##"`):<br/>
The `b#` will be found and removed,
and what is left is `"a#"`,
so we should expect to remove that `a#` as well.<br/>
But the position at which the regex looks for the next
occurrence of the `/.\#/` pattern is where the `b#` was found,
which is _behind_ the `a`.<br/>
That's why the `a#` will *not* be removed.

The solution is to *repeat* the substitution, until we don't find any  `/.\#/` anymore.

We can use the substitution itself as the controlling expression of a `while` loop. The loop body remains empty, because everything we need is done in the loop condition already.

We apply that substitution loop to both strings, then we return the result  of the comparison of the processed strings.

In the end it looks like this:

```perl
sub backspace_compare( $str1, $str2 ) {
    for ( $str1, $str2 ) {
        do {} while s/.\#//g;
    }
    return $str1 eq $str2;
}
```

**UPDATE:**

Niels van Dijke's
[posted solution](https://www.facebook.com/groups/theweeklychallengegroup/permalink/1357372518846815/),
using `s/[^#]#//` for the substitution,
made me think what can happen with the more simple `s/.#//g` in my solution
(still using it repeatedly).<br/>
And in fact my solution failed for an example like `"abc###"`:
it would remove the `c#` and then the `##` in the first go,
leaving `"ab"`, and ending the loop.

I also learned that it's not necessary to escape the `#` in a regular expression
(at least as long as we don't use `/x`).

So it has to be either this:
```perl
        do {} while s/.#//;		# No '/g'.
```
which restarts the search from the beginning after everysubstitution,
or this, using Niels' pattern:
```perl
        do {} while s/[^#]#//g;
```
to keep the 'mini-optimization' of using `/g`
to at least replace all possible non-overlapping sequences before restarting.<br/>
And that's my updated solution:

```perl
sub backspace_compare( $str1, $str2 ) {
    for ( $str1, $str2 ) {
        do {} while s/[^#]#//g;
    }
    return $str1 eq $str2;
}
```

#### **Thank you for the challenge!**

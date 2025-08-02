# Find Twice and Reverse Once

**Challenge 318 solutions in Perl by Matthias Muth**

## Task 1: Group Position

> You are given a string of lowercase letters.<br/>
> Write a script to find the position of all groups in the given string. Three or more consecutive letters form a group. Return "” if none found.
>
> **Example 1**
>
> ```text
> Input: $str = "abccccd"
> Output: "cccc"
>```
> 
>**Example 2**
> 
>```text
> Input: $str = "aaabcddddeefff"
> Output: "aaa", "dddd", "fff"
> ```
>
> **Example 3**
>
> ```text
>Input: $str = "abcdd"
> Output: ""
> ```

This is a very interesting task.
Recognizing sequences of same characters is almost a standard idiom in regular expressions,
using 'backreferences' to capture groups.
A regular expression that matches three or more *same* characters might look like this:

```perl
    m/(.)\g{-1}{2,}/
```

The `(.)` captures the first character.
Then we look for two or more occurrences of what was captured.
To reference the capture buffer, `\g{-1}` is used,
which is a *relative* reference to the immediately preceding capture group.
The `{2,}` defines how many of what precedes are accepted:
at least two, with no restriction to the maximum number.

The easiest way to match all wanted patterns in only one statement
is to use the `/g` *global* modifier for the regular expression.
In list context (which is what we want), if there are any parentheses,
it will return everything that was captured in parentheses.
We actually *do* have parentheses,
at least for the single character that we the backreference.
This means that for capturing the whole sequence,
we need to put another set of parentheses around everything
to get the complete match into the resulting list.<br/>
Let's do that:

```perl
    my @groups = $str =~ /( (.)\g{-1}{2,} )/xg;
```

But wait.
We are getting back *every* capture,
and we already captured the first letter of the sequence,
for backreferencing it.
Which is why for Example 2 (`"aaabcddddeefff"`),
we get this list as a result:

```perl
    ("aaa", "a", "dddd", "d", "fff", "f")
```

So we actually have to filter away the single characters that we captured.
For example, like this:

```perl
    my @groups = grep ! /^.$/, $str =~ /( (.)\g{-1}{2,} )/xg;
```

Or we can filter and keep only 'real' sequences of multiple characters, like this:

```perl
    my @groups = grep length > 1, $str =~ /( (.)\g{-1}{2,} )/xg;
```

We can also capture the sequences it in a more 'traditional' way, in case we want to avoid the overhead of capturing something that we don't need later and then need to remove again:

```perl
    my @groups;
    push @groups, $&
        while $str =~ /(.)\g{-1}{2,}/g;
```

This still uses the `/g` *global* modifier, but in a loop (using scalar return values). It collects the matches (`$&`), not the captures, so only what we really need.

But I actually prefer the previous solution, because if possible, I like to stay away from the more 'technical' tasks like pushing elements onto an array (or from writing loops for that matter), delegating those tasks to the inner workings of the language.<br/>
More efficient? I don't know.<br/>
More elegant? Maybe!

For the return value, we need to do something special when we did not find any matches. We need to return an empty string then, not just an empty list. No problem:

```perl
    return @groups ? @groups : "";
```

So here is my personal favorite solution for this task:   

```perl
sub group_position( $str ) {
    my @groups = grep length > 1, $str =~ /( (.)\g{-1}{2,} )/xg;
    return @groups ? @groups : "";
}
```


## Task 2: Reverse Equals

> You are given two arrays of integers, each containing the same elements as the other.<br/>
> Write a script to return true if one array can be made to equal the other by reversing exactly one contiguous subarray.
>
> **Example 1**
>
> ```text
> Input: @source = (3, 2, 1, 4)
>        @target = (1, 2, 3, 4)
> Output: true
>
> Reverse elements: 0-2
>```
> 
>**Example 2**
> 
>```text
> Input: @source = (1, 3, 4)
>     @target = (4, 1, 3)
>    Output: false
> ```
>
> **Example 3**
>
> ```text
>Input: @source = (2)
>     @target = (2)
> Output: true
>    ```

This task is not so trivial. I split it up into two parts:

* Determine where the 'contiguous subarray' starts and ends that needs to be reversed to match the same part in the other array.
* Check whether that subarray *correctly matches* the other part once it is reversed.

For the first part, this means to find the first entry that is not the same in both arrays. Then, we need the the *last* entry that differs.

We need to look for that one starting from the end, because if we just continued walking through the array after finding the first difference until we found an entry that's the same, we might miss differing entries further on. We really need the last one.

Using `first` from `List::Util` for both searches (instead of a loop), that can look like this:

```perl
    my ( $start, end ) = (
        ( first { $source->[$_] != $target->[$_] } keys $source->@* ),
        ( first { $source->[$_] != $target->[$_] } reverse keys $source->@* ),
    );
```

For the second part, comparing the two subarrays, I use the `all` function (also from `List::Util`) to go through elements from the first array in forward direction, and from the second array in reverse. They all need to be the same.

Of course we can do that only when we really found a difference. Interesting twist: What if we didn't find any differences?

It then depends on whether the arrays contain any entries at all.<br/>
If the arrays are not empty, we can choose any element and declare it a one-element sub-array. Of course reversing that single element results in the same, so we might say that we 'make the two arrays equal' by 'reversing' any single letter, even if they were equal before already. So we can return 'true'.<br/>If the arrays are both empty, we do not have anything to reverse, and we need to output 'false'.

Putting it all together, I get this: 

```perl
use v5.36;

use List::Util qw( all first );

sub reverse_equals( $source, $target ) {
    my ( $start, $end ) = (
        ( first { $source->[$_] != $target->[$_] } keys $source->@* ),
        ( first { $source->[$_] != $target->[$_] } reverse keys $source->@* ),
    );
    return defined $start
        ? all { $source->[ $start + $_ ] == $target->[ $end - $_ ] }
            0 .. ( $end - $start )
        : $source->@* > 0;
}
```

For testing the edge cases, I added some extra tests to the examples from the task description.

I can't say it often enough how great it is that `Test2::V0` is now a core module, no need for CPAN!

```perl
use Test2::V0 qw( -no_srand );

is reverse_equals( [3, 2, 1, 4], [1 .. 4] ),T,
    'Example 1: reverse_equals( [3, 2, 1, 4], [1 .. 4] ) is true';
is reverse_equals( [1, 3, 4], [4, 1, 3] ), F,
    'Example 2: reverse_equals( [1, 3, 4], [4, 1, 3] ) is false';
is reverse_equals( [2], [2] ), T,
    'Example 3: reverse_equals( [2], [2] ) is true';
is reverse_equals( [], [] ), F,
    'Test 1: reverse_equals( [], [] ) is false';
is reverse_equals( [], [] ), F,
    'Test 2: reverse_equals( [2], [] ) is false';
is reverse_equals( [], [] ), F,
    'Test 3: reverse_equals( [], [3] ) is false';

done_testing;
```



#### **Thank you for the challenge!**

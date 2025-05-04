# Does 'Weekly' Have a Happy (Vowel) Ending?

**Challenge 319 solutions in Perl by Matthias Muth**

## Task 1: Word Count

> You are given a list of words containing alphabetic characters only.<br/>
> Write a script to return the count of words either starting with a vowel or ending with a vowel.
>
> **Example 1**
>
> ```text
> Input: @list = ("unicode", "xml", "raku", "perl")
> Output: 2
> 
> The words are "unicode" and "raku".
> ```
>
> **Example 2**
>
> ```text
> Input: @list = ("the", "weekly", "challenge")
> Output: 2
> ```
>
> **Example 3**
>
> ```text
> Input: @list = ("perl", "python", "postgres")
> Output: 0
> ```

What is a vowel, really?<br/>
Doesn't 'weekly' happily end in a vowel?<br/>
Don't worry (oh, another one!). <br/>
I'm a programmer, so I'm infallible!
And as I have grown up with ASCII, so there can only be one meaning of what a vowel really is.<br/>Here it is. These are <u>The Vowels</u>:

``` 
          a  e  i  o  u
```

So please, no [Sunday sermons](https://en.wikipedia.org/wiki/Vowel) about vowels actually being sounds, not letters...<br/>And no discussions about [vowels in Unicode](https://stackoverflow.com/questions/38792789/how-to-match-unicode-vowels)! (Hint: The concept of a vowel does not even exist in Unicode!)

So first let's put out a clear statement to declare what vowels are. Once and for all, and no matter which case:

```perl
    my $vowel = qr/[aeiou]/i;
```

Ok. Feels better now.

The rest is easy! Let's use some readable regular expression to match 'words either starting with a vowel or ending with a vowel':

```perl
    / ^ $vowel | $vowel $ /xi
```

That's easy, isn't it?

And now we will let `grep` do the counting (it does so in scalar context), and we are done:

```perl
use v5.36;

sub word_count( @list ) {
    my $vowel = qr/[aeiou]/i;
    return scalar grep / ^ $vowel | $vowel $ /xi, @list;
}
```

Makes me happi!



## Task 2: Minimum Common

> You are given two arrays of integers.<br/>
> Write a script to return the minimum integer common to both arrays. If none found return -1.
>
> **Example 1**
>
> ```text
> Input: @array_1 = (1, 2, 3, 4)
>        @array_2 = (3, 4, 5, 6)
> Output: 3
>
> The common integer in both arrays: 3, 4
> The minimum is 3.
>```
> 
>**Example 2**
> 
>```text
> Input: @array_1 = (1, 2, 3)
>     @array_2 = (2, 4)
>    Output: 2
> ```
>
> **Example 3**
>
> ```text
>Input: @array_1 = (1, 2, 3, 4)
>     @array_2 = (5, 6, 7, 8)
> Output: -1
>    ```

I first tried to find something like a 'symmetric' solution. Kind of combining the two arrays, and then see if I could derive the result from there. I didn't come up with anything clever.

Then, my idea for an 'asymmetric' solution was to walk through one array (that's one side), and check for existence of the element in the other (that's the second side).

As the number also has to be the smallest possible one, I first sort it numerically. Then we can return `true` for the first element that also exists in the second array.

Checking for existence is best done with an 'existence hash':

```perl
    my %is_in_array_2 = map { ( $_ => 1 ) } $array_2->@*;
```

The sorting and checking fits in one statement, avoiding a `for` loop, when we use  `first`  from `List::Util`, and then use the 'defined or' operator to return the special value `-1` if we don't find any entry that matches the condition.

That can look like this:

```perl
# First solution, using 'sort'.
use v5.36;
use List::Util qw( first );
sub minimum_common_with_sorting( $array_1, $array_2 ) {
    my %is_in_array_2 = map { ( $_ => 1 ) } $array_2->@*;
    return
        ( first { $is_in_array_2{$_} }
            sort { $a <=> $b } $array_1->@* )
        // -1;
}
```

I implemented this solution first, and  it then it kept on thinking about how I could avoid the `sort`, and the multiple passes needed for `sort` and `first`.

Of course. It's so easy!<br/>
Finding the smallest number in a list of numbers:
That's the reason why the `min` function exists!

So I flip things around, *first* walking through the first array *without* sorting,
but filtering out only those elements that also exist in the second array. This is the same as finding the *intersection* of the two sets of numbers (notwithstanding repeated elements).

```perl
    grep $is_in_array_2{$_}, $array_1->@*
```

Then find the (hooray!) minimum of those filtered common values:

```perl
    min( grep $is_in_array_2{$_}, $array_1->@* )
```
Again, if there is no such element, I use the 'defined or' operator to return `-1`.

Not only that `min` (also from `List::Util`) has a lower time complexity than `sort`,
but the solution also is shorter.<br/>
And I think it is easier to understand, too: 

```perl
# My preferred solution.
use v5.36;
use List::Util qw( min );
sub minimum_common( $array_1, $array_2 ) {
    my %is_in_array_2 = map { ( $_ => 1 ) } $array_2->@*;
    return min( grep $is_in_array_2{$_}, $array_1->@* ) // -1;
}
```

Let's call it 'evolutionari programming'.<br/>
That's OK for me!

#### **Thank you for the challenge!**

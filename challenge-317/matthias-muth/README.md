# Friendly Acronyms

**Challenge 317 solutions in Perl by Matthias Muth**

## Task 1: Acronyms

> You are given an array of words and a word.<br/>
> Write a script to return true if concatenating the first letter of each word in the given array matches the given word, return false otherwise.
>
> **Example 1**
>
> ```text
> Input: @array = ("Perl", "Weekly", "Challenge")
>        $word  = "PWC"
> Output: true
>```
> 
>**Example 2**
> 
>```text
> Input: @array = ("Bob", "Charlie", "Joe")
>     $word  = "BCJ"
>    Output: true
> ```
>
> **Example 3**
>
> ```text
>Input: @array = ("Morning", "Good")
>     $word  = "MM"
> Output: false
>    ```

Oh. No regexes this week? Maybe just a small one...

Getting the first characters of the strings in the array can be done with getting `substr( $_, 0, 1 )` of each of them. Then we `join` them together to get the acronym for those words. All there's left to do is to compare whether that is equal to `$word`.

But I can't really live without regexes. That's why I prefer using `/^(.)/` to get the first character of each string.<br/>
Isn't that nicer?<br/>And easier to read and understand than the three-parameter `substr`?

So here it is:  

```perl
use v5.36;

sub acronyms( $array, $word ) {
    return join( "", map /^(.)/, $array->@* ) eq $word
}
```

## Task 2: Friendly Strings

> You are given two strings.<br/>
> Write a script to return true if swapping any two letters in one string match the other string, return false otherwise.
>
> **Example 1**
>
> ```text
> Input: $str1 = "desc", $str2 = "dsec"
> Output: true
> ```
>
> **Example 2**
>
> ```text
> Input: $str1 = "fuck", $str2 = "fcuk"
> Output: true
> ```
>
> **Example 3**
>
> ```text
> Input: $str1 = "poo", $str2 = "eop"
> Output: false
> ```
>
> **Example 4**
>
> ```text
> Input: $str1 = "stripe", $str2 = "sprite"
> Output: true
> ```

The two strings are 'friendly' when they are equal on all positions but two.<br/>
And for those two remaining 'unequal' positions, the two characters from the first string must be the same as the characters from the second string, but reversed. I'll explain that in more detail further below.

Let's first deal with comparing the strings at corresponding positions.<br/>
To do that, we `split` up each string into an array of characters, then we use `zip` (from `List::Util` in core) to get the characters at corresponding positions together:

```perl
    zip [ split "", $str1 ], [ split "", $str2 ];
```

`zip` returns a list of two-element anonymous arrays that each contain the characters from `$str1` and `$str2` at the same position.

Now we only need to compare the two characters in each of the small anonymous arrays.

Actually we will completely ignore all 'equal' characters. Neither do we care about what characters there are, nor about how many of them there are. We are only interested in the *unequal* ones. So let's `grep` these:

```perl
    my @unequals =
        grep $_->[0] ne $_->[1],
            zip [ split "", $str1 ], [ split "", $str2 ];
```

Now that we have the unequal characters separated out, we can check whether they are from exactly two positions:

```perl
    @unequals == 2
```
If we passed this test, we still need to check that the characters are 'swapped'.

In Example 4 (`$str1 = "stripe", $str2 = "sprite"`), the unequal pairs are these:

```perl
    #        from $str1 $str2
    $unequal[0] = [ "t", "p" ];
    $unequal[1] = [ "p", "t" ];
```
We can 'swap' them back into place:
```perl
    #        from $str1 $str2
    $unequal[0] = [ "t", "t" ];
    $unequal[1] = [ "p", "p" ];
```
and then compare whether all pairs are now equal. That's the 'official' way.

But in that 2x2 matrix it doesn't matter whether we swap one column, as we have just done, and then compare whether each row has two equal values, or whether we reverse one of the rows, and then compare whether the two rows are the same. Like this:
```perl
    [ "t", "p" ];    # original $unequal[0]
    [ "t", "p" ];    # *reversed* $unequal[1] 
```
But actually, this second option is much easier and shorter to implement.<br/>
Comparing the rows, after swapping one of them, is just:
```perl
    "$unequals[0]->@[0,1]" eq "$unequals[1]->@[1,0]"
```
Shamelessly using the double quotes to concatenate the two values, so that we then can do a simple string comparison instead of looping through the arrays or replicating the condition.

Maybe it's not bad to have some of these explanations, but I think the whole solution looks quite 'perlish':

```perl
use v5.36;

use List::Util qw( zip );

sub friendly_strings( $str1, $str2 ) {
    my @unequals =
        grep $_->[0] ne $_->[1],
            zip [ split "", $str1 ], [ split "", $str2 ];
    return @unequals == 2 && "$unequals[0]->@[0,1]" eq "$unequals[1]->@[1,0]";
}
```

#### **Thank you for the challenge!**

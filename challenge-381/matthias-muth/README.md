# Watch Your Zeros, and Don’t Get Off by One!

**Challenge 380 solutions in Perl by Matthias Muth**

## Task 1: Sum of Frequencies

> You are given a string consisting of English letters.<br/>
> Write a script to find the vowel and consonant with maximum frequency. Return the sum of two frequencies.
>
> **Example 1**
>
> ```text
> Input: $str = "banana"
> Output: 5
>
> Vowel: "a" appears 3 times.
> Consonant: "n" appears 2 times, "b" appears 1 time.
>
> Max frequency of vowel: 3
> Max frequency of consonant: 2
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "teestett"
> Output: 7
>
> Vowel: "e" appears 3 times.
> Consonant: "t" appears 4 times, "s" appears 1 time.
>
> Max frequency of vowel: 3
> Max frequency of consonant: 4
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "aeiouuaa"
> Output: 3
>
> Vowel: "a" appears 3 times, "u" 2 times, "e", "i", "o" 1 time each.
> Consonant: None.
>
> Max frequency of vowel: 3
> Max frequency of consonant: 0
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "rhythm"
> Output: 2
>
> Vowel: None
> Consonant: "h" appears 2 times, "r", "y", "t", "m" 1 time each.
>
> Max frequency of vowel: 0
> Max frequency of consonant: 2
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "x"
> Output: 1
>
> Vowel: None
> Consonant: "x" appears 1 time.
>
> Max frequency of vowel: 0
> Max frequency of consonant: 1
> ```

For the result,
we need to count the vowels and the consonants, separately,
and we need to do so for each vowel separately, and for each consonant separately.

I usually let `frequency` from `List::MoreUtils`
do the work of counting,
but in this case I found it easier to increment the counts
directly within the loop that selects the single characters,
like this:
```
    my ( %vowel_freqs, %other_freqs );
    /^[aeiou]/ ? ++$vowel_freqs{$_} : ++$other_freqs{$_}
        for fc( $str ) =~ /[a-z]/g;
```
The `for` loop (or '`for` statement modifier', actually)
delivers single letters from the string, ignoring anything else, like whitespace or punctuation for example.
Even if the task description promises that we have a string of English letters only, I consider it good style to write code that is a bit forgiving.

But it does one more thing: it folds the letters to their lowercase representation, using `fc` (*fold case*). See [perldoc](https://perldoc.perl.org/functions/fc) for an explanation why `lc` (*lowercase*) may not be correct in some cases. Again, we don't expect any mixed case input strings, but who knows...

We now have two hashes of frequencies. For the result to be returned, we need to add the maximum value of each of them. In case we don't have any vowels, or any consonants, there will not be a maximum. Instead of checking the result for `undef` by using a `//` *defined-or* operator, I simply add a zero to the list of values passed to `max`, which solves that problem more easily.

So here is my solution for this task:

```perl
use v5.36;
use List::Util qw( max );

sub sum_of_frequencies( $str ) {
    my ( %vowel_freqs, %other_freqs );
    /^[aeiou]/ ? ++$vowel_freqs{$_} : ++$other_freqs{$_}
        for fc( $str ) =~ /[a-z]/g;
    return max( 0, values %vowel_freqs ) + max( 0, values %other_freqs );
}
```

## Task 2: Reverse Degree

> You are given a string.<br/>
> Write a script to find the reverse degree of the given string.<br/>
> For each character, multiply its position in the reversed alphabet (‘a’ = 26, ‘b’ = 25, …, ‘z’ = 1) with its position in the string. Sum these products for all characters in the string to get the reverse degree.
>
> **Example 1**
>
> ```text
> Input: $str = "z"
> Output: 1
>
> Reverse alphabet value of "z" is 1.
> Position 1: 1 x 1
> Sum of product: 1
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "a"
> Output: 26
>
> Reverse alphabet value of "a" is 26.
> Position 1: 1 x 26
> Sum of product: 26
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "bbc"
> Output: 147
>
> Reverse alphabet value of "b" is 25 and "c" is 24.
> Position 1: 1 x 25
> Position 2: 2 x 25
> Position 3: 3 x 24
> Sum of product: 25 + 50 + 72 => 147
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "racecar"
> Output: 560
>
> Reverse alphabet value of "r" is 9, "a" is 26, "c" is 24 and "e" is 24.
> Position 1: 1 x 9
> Position 2: 2 x 26
> Position 3: 3 x 24
> Position 4: 4 x 22
> Position 5: 5 x 24
> Position 6: 6 x 26
> Position 7: 7 x 9
> Sum of product: 9 + 52 + 72 + 88 + 120 + 156 + 63
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "zyx"
> Output: 14
>
> Reverse alphabet value of "z" is 1, "y" is 2 and "x" is 3.
> Position 1: 1 x 1
> Position 2: 2 x 2
> Position 3: 3 x 3
> Sum of product: 1 + 4 + 9
> ```

We need to have a loop over the characters. At the same time we need the 'position' of each character, for computing the product which we add to the sum. Typical Perl loops are zero-based, but the 'position' is one based.

If we loop over the (zero-based) character indexes in the string, we always need to add `1` to get the (one-based) 'position' for calculating that product.

If we loop over the (one-based) 'position', we always need to always need to *subtract* `1` to get the (zero-based) character index.

Both ways are not nice, because mixing zero- and one-based indexing in the same loop can be confusing.

But there is a third way: we completely eliminate all zero-based processing, by looping not over the character index, but over the characters themselves. This comes at the cost of using a separate variable for the (one-based) 'position'. But actually it makes the code so much simpler that I prefer this construction over the two above:

```perl
use v5.36;
use List::Util qw( sum );

sub reverse_degree( $str ) {
    my $position = 1;
    return sum(
        map $position++ * ( ord( "z" ) + 1 - ord( $_ ) ),
            split //, $str
    );
}
```

Of course we have one more 'off-by-one' situation: The 'position in the reversed alphabet' (as opposed to the 'position in the string'). We have to add one to the character value (`ord`) of the letter `'z'` before we subtract the current character's character value to get the correct position. But I guess that is clear enough.

#### **Thank you for the challenge!**

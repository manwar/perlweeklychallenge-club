# Avoid Common Traps, and Reduce the XOR

**Challenge 308 solutions in Perl by Matthias Muth**

## Task 1: Count Common

> You are given two array of strings, `@str1` and `@str2`.<br/>
> Write a script to return the count of common strings in both arrays.
>
> **Example 1**
>
> ```text
> Input: @str1 = ("perl", "weekly", "challenge")
>        @str2 = ("raku", "weekly", "challenge")
> Output: 2
> ```
> **Example 2**
>
> ```text
> Input: @str1 = ("perl", "raku", "python")
>        @str2 = ("python", "java")
> Output: 1
> ```
> **Example 3**
>
> ```text
> Input: @str1 = ("guest", "contribution")
>        @str2 = ("fun", "weekly", "challenge")
> Output: 0
> ```

**First try**

The first idea could be to make it short and count all same words,
no matter whether they are in `@str1` or `@str2`.
Then return the number of words that appear exactly twice. `grep` in scalar context delivering the number of matches is very helpful:

```perl
use v5.36;
sub count_common( $str1, $str2 ) {
    my %word_counts;
    ++$word_counts{$_}
        for $str1->@*, $str2->@*;
    return scalar grep $_ == 2, values %word_counts;
}
```
(Passing in the two arrays as array-refs.)

This simple solution works well for both examples.

**Avoid the trap (again!)**

BUT! What happens if a word is contained *twice* in the same array,
like `"weekly"` in this extra example:

> **Extra example 1**
>
> ```text
> Input: @str1 = ("perl", "weekly", "challenge", "weekly")
>     @str2 = ("raku", "weekly", "challenge")
> Output: 2
> "weekly" and "challenge" appear in both arrays.
> ```

It will be counted three times, and our result will be wrong.<br/>
So actually we have to count each word in array exactly once,
even if it appears several times.<br/>
We can use `uniq` on each word list to reduce multiple appearances into single ones:

```perl
use v5.36;
use List::Util qw( uniq );
sub count_common( $str1, $str2 ) {
    my %word_counts;
    ++$word_counts{$_}
        for uniq( $str1->@* ), uniq( $str2->@* );
    return scalar grep $_ == 2, values %word_counts;
}
```

That's better.

**Make it simple**

But instead of importing and using a module,
we might as well avoid that overhead
and create simple 'existence lookups' for the two lists ourselves.
Actually we are implementing `uniq` ourselves, by a simple hash assignment.

Then we check for all keys of the first lookup hash
whether they also exist in the second one,
and let `grep` do the counting again.

This is the solution that I like best:

```perl
sub count_common( $str1, $str2 ) {
    my %words_1 = map { $_ => 1 } $str1->@*;
    my %words_2 = map { $_ => 1 } $str2->@*;
    return scalar grep $words_2{$_}, keys %words_1;
}
```

## Task 2: Decode XOR

> You are given an encoded array and an initial integer.<br/>
> Write a script to find the original array that produced the given encoded array.<br/>
> It was encoded such that `encoded[i] = orig[i] XOR orig[i + 1]`.
>
> **Example 1**
>
> ```text
> Input: @encoded = (1, 2, 3), $initial = 1
> Output: (1, 0, 2, 1)
> Encoded array created like below, if the original array was (1, 0, 2, 1)
> $encoded[0] = (1 xor 0) = 1
> $encoded[1] = (0 xor 2) = 2
> $encoded[2] = (2 xor 1) = 3
> ```
> **Example 2**
>
> ```text
> Input: @encoded = (6, 2, 7, 3), $initial = 4
> Output: (4, 2, 0, 7, 4)
> ```

The good thing about the XOR operation is that it is reversible.
When we XOR any binary value with itself, we get zero.
Also, when we XOR a given value with another one,
and then we do that once again, we get the original value back.

This helps a lot for this solution. What we know is this:
```math
encoded_i = orig_i \text{ XOR } orig_{i + 1}
```
But we can turn this around and say that:
```math
orig_{i+1} = orig_i \text{ XOR } encoded_i
```
We get $orig_0$ from our `$initial` value.<br/>
Then we compute the next $orig$ values from the previous ones,
XORing them with the matching $encoded$ value, in a loop:<br/>
```perl
sub decode_xor_1( $encoded, $initial ) {
    my @orig;
    $orig[0] = $initial;
    $orig[ $_ + 1 ] = $orig[$_] ^ $encoded->[$_]
        for keys $encoded->@*;
    return @orig;
}
```

**Use `reductions` to reduce the code**

Thinking about how to generate the whole array in one statement,
I remembered how the `reduce` function (from the `List::Util` core module) goes through a list
and builds up the final result by combining each intermediate result
with the next list element, in a way that we can specify in a code block.

The `reductions` function (also from `List::Util`) does the same thing,
but instead of returning the end result only,
it returns all intermediate results, too.

And this is exactly what we need.

We need to combine the previous result ($orig_i$)
with the next list element ($encoded_i$).
We combine them doing an XOR of the two values.<br/>
We start with $orig_0$ = `$initial`,
the rest of the list is the array referenced by the `$encoded` array-ref.

This gives us a very concise and 'elegant' solution:

```perl
sub decode_xor( $encoded, $initial ) {
    return reductions { $a ^ $b } $initial, $encoded->@*;
}
```

Yes, I know.<br/>
*Elegance is in the eye of the beholder*. But ... :-)

#### **Thank you for the challenge!**

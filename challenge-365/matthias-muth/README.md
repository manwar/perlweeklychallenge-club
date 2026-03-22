# Splitting and Summing and Checking and Counting

**Challenge 365 solutions in Perl by Matthias Muth**

## Task 1: Alphabet Index Digit Sum

> You are given a string \$str consisting of lowercase English letters, and an integer \$k.<br/>
> Write a script to convert a lowercase string into numbers using alphabet positions (a=1 … z=26), concatenate them to form an integer, then compute the sum of its digits repeatedly \$k times, returning the final value.
>
> **Example 1**
>
> ```text
> Input: $str = "abc", $k = 1
> Output: 6
>
> Conversion: a = 1, b = 2, c = 3 -> 123
> Digit sum: 1 + 2 + 3 = 6
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "az", $k = 2
> Output: 9
>
> Conversion: a = 1, z = 26 -> 126
> 1st sum: 1 + 2 + 6 = 9
> 2nd sum: 9
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "cat", $k = 1
> Output: 6
>
> Conversion: c = 3, a = 1, t = 20 -> 3120
> Digit sum: 3 + 1 + 2 + 0 = 6
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "dog", $k = 2
> Output: 8
>
> Conversion: d = 4, o = 15, g = 7 -> 4157
> 1st sum: 4 + 1 + 5 + 7 = 17
> 2nd sum: 1 + 7 = 8
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "perl", $k = 3
> Output: 6
>
> Conversion: p = 16, e = 5, r = 18, l = 12 -> 1651812
> 1st sum: 1 + 6 + 5 + 1 + 8 + 1 + 2 = 24
> 2nd sum: 2+4 = 6
> 3rd sum: 6
> ```

In the first step, we turn the letters into numbers, and we concatenate these numbers into a string.<br/>
In this step, we risk a numeric overflow if we immediately interpret this concatenation of numbers numerically and the resulting number is larger than $2^{63}-1$ (more than about 18 digits, roughly). That's why we keep it as a string for now.

The next step is a loop that reduces the current number to its digit sum. Even after the first operation we are safe if we want to interpret the checksum numerically (it is difficult to find a string of digits whose *sum* is larger than $2^{63}-1$ ...). But it is so much easier to build the checksum letting Perl do the work of separating the digits:

```perl
    sum( split "", $number )
```

It really helps here that a Perl scalar is not a strongly typed as an entity.

The loop iterates until either there is only one digit left (the length of the number is 1), or the number of operations to do, given as the parameter `$k and auto-decremented in every iteration, was brought down to zero.

The resulting single digit the is returned. 

```perl
use v5.36;
use List::Util qw( sum );

sub alphabet_index_digit_sum( $str, $k ) {
    # Turn the letters into a string of numbers.
    my $sum_string = join "", map ord( $_ ) - ord( "a" ) + 1, split "", $str;
    # Compute the checksum repeatedly until only one digit is left
    # or the number of operations left do to is down to zero.
    $sum_string = sum( split "", $sum_string )
        while length( $sum_string ) > 1 && $k-- > 0;
    return $sum_string;
}
```

## Task 2: Valid Token Counter

> You are given a sentence.<br/>
> Write a script to split the given sentence into space-separated tokens and count how many are valid words. A token is valid if it contains no digits, has at most one hyphen surrounded by lowercase letters, and at most one punctuation mark (!, ., ,) appearing only at the end.
>
> **Example 1**
>
> ```text
> Input: $str = "cat and dog"
> Output: 3
>
> Tokens: "cat", "and", "dog"
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "a-b c! d,e"
> Output: 2
>
> Tokens: "a-b", "c!", "d,e"
> "a-b" -> valid (one hyphen between letters)
> "c!"  -> valid (punctuation at end)
> "d,e" -> invalid (punctuation not at end)
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "hello-world! this is fun"
> Output: 4
>
> Tokens: "hello-world!", "this", "is", "fun"
> All satisfy the rules.
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "ab- cd-ef gh- ij!"
> Output: 2
>
> Tokens: "ab-", "cd-ef", "gh-", "ij!"
> "ab-"   -> invalid (hyphen not surrounded by letters)
> "cd-ef" -> valid
> "gh-"   -> invalid
> "ij!"   -> valid
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "wow! a-b-c nice."
> Output: 2
>
> Tokens: "wow!", "a-b-c", "nice."
> "wow!"  -> valid
> "a-b-c" -> invalid (more than one hyphen)
> "nice." -> valid
> ```

The work in this task can be done by `split` to separate the tokens, and by a regular expression to validate them.

```perl
    split " ", $str
```

returns the list of tokens, no matter how much whitespace was used to separate them.

The regular expression that does the validation is composed of three parts:

* a sequence of one or more lower case letters,
* an optional second part containing a single hyphen, followed by another sequence of one or more lower case letters,
* an optional final single punctuation mark (one of `!`, `.`, `,`).

This translates to the following pattern:

```perl
    /^ [a-z]+ (?: - [a-z]+ )? [!,.]? $/x
```

Selecting the valid tokens only (using the above pattern) and counting them is a perfect task for `grep`, which in scalar context returns the count of elements passing the filter.

This means that this task only needs one single statement:  

```perl
use v5.36;

sub valid_token_counter( $str ) {
    return scalar grep /^ [a-z]+ (?: - [a-z]+ )? [!,.]? $/x,
        split " ", $str;
}
```

#### **Thank you for the challenge!**

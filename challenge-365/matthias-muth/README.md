#  Decrypted `"715#15#15#112#"`: goooal!

**Challenge 364 solutions in Perl by Matthias Muth**

## Task 1: Decrypt String

> You are given a string formed by digits and ‘#'.<br/>
> Write a script to map the given string to English lowercase characters following the given rules.
>
> - Characters 'a' to 'i' are represented by '1' to '9' respectively.
> - Characters 'j' to 'z' are represented by '10#' to '26#' respectively.
>
> **Example 1**
>
> ```text
> Input: $str = "10#11#12"
> Output: "jkab"
> 
> 10# -> j
> 11# -> k
> 1   -> a
> 2   -> b
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "1326#"
> Output: "acz"
> 
> 1   -> a
> 3   -> c
> 26# -> z
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "25#24#123"
> Output: "yxabc"
> 
> 25# -> y
> 24# -> x
> 1   -> a
> 2   -> b
> 3   -> c
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "20#5"
> Output: "te"
> 
> 20# -> t
> 5   -> e
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "1910#26#"
> Output: "aijz"
> 
> 1   -> a
> 9   -> i
> 10# -> j
> 26# -> z
> ```

The first task can be solved by a single statement, based on regular expressions.

The pattern uses alternations (`|`), matching either a two-digit sequence followed by a '#' character, or a single digit. It is important to put the two-digit pattern first, because otherwise the single-digit pattern would 'steal' the first digit of any two-digit patterns.

The two-digit pattern should be specific about the number range it covers: 10 to 26. I use alternations again: either a `1` followed by any digit, or a `2` followed by any one of `0` to `6`.

Both the two-digit sequence and the single digit are captured, to be used in the second part, which is the substitution of the digits by the corresponding characters. The substitution character is determined the usual way: using the numeric value of the character `"a"`, plus the captured digits as a number, minus 1, and the result transformed back into a character.

The flags used in the substitution are `/x` for readability, `/e` to use a Perl expression as the replacement, not a string (which is why I also change the delimiters from the typical `s///` to `s<...>{...}`, to highlight the fact that the substitution is code, not a just a string), then `/g` for global (repeated) substitutions, and last, but not least, `/r` to get the resulting string instead of  the number of substitutions done.

Here is my solution:

```perl
use v5.36;

sub decrypt_string( $str ) {
    return $str =~ s< ( 1\d | 2[0-6] ) \# | ( \d )>{
        chr( ord( 'a' ) + ( $1 // $2 ) - 1 )
    }xegr;
}
```

## Task 2: Goal Parser

> You are given a string, $str.<br/>
> Write a script to interpret the given string using Goal Parser.<br/>
> The Goal Parser interprets “G” as the string “G”, “()” as the string “o”, and “(al)” as the string “al”. The interpreted strings are then concatenated in the original order.
>
> **Example 1**
>
> ```text
> Input: $str = "G()(al)"
> Output: "Goal"
>
> G    -> "G"
> ()   -> "o"
> (al) -> "al"
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "G()()()()(al)"
> Output: "Gooooal"
>
> G       -> "G"
> four () -> "oooo"
> (al)    -> "al"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "(al)G(al)()()"
> Output: "alGaloo"
>
> (al) -> "al"
> G    -> "G"
> (al) -> "al"
> ()   -> "o"
> ()   -> "o"
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "()G()G"
> Output: "oGoG"
>
> () -> "o"
> G  -> "G"
> () -> "o"
> G  -> "G"
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "(al)(al)G()()"
> Output: "alalGoo"
>
> (al) -> "al"
> (al) -> "al"
> G    -> "G"
> ()   -> "o"
> ()   -> "o"
> ```

The second task, too, can be solved by regular expression substitutions. Here, I chose to deal separately with the two necessary substitutions (only two, because substituting a "G" for a "G" isn't really a substitution).

Chaining two substitutions in a straight-forward one-liner:

```perl
use v5.36;

sub goal_parser( $str ) {
    return $str =~ s/ \(\) /o/xgr =~ s/ \(al\) /al/xgr;
}
```

#### **Thank you for the challenge!**

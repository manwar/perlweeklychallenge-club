# "nbyqyyefswbuffyhay"

**Challenge 358 solutions in Perl by Matthias Muth**

## Task 1: Max Str Value

> You are given an array of alphanumeric string, @strings.<br/>
> Write a script to find the max value of alphanumeric string in the given array. The numeric representation of the string, if it comprises of digits only otherwise length of the string.
>
> **Example 1**
>
> ```text
> Input: @strings = ("123", "45", "6")
> Output: 123
>
> "123" -> 123
> "45"  -> 45
> "6"   -> 6
> ```
>
> **Example 2**
>
> ```text
> Input: @strings = ("abc", "de", "fghi")
> Output: 4
>
> "abc"  -> 3
> "de"   -> 2
> "fghi" -> 4
> ```
>
> **Example 3**
>
> ```text
> Input: @strings = ("0012", "99", "a1b2c")
> Output: 99
>
> "0012"  -> 12
> "99"    -> 99
> "a1b2c" -> 5
> ```
>
> **Example 4**
>
> ```text
> Input: @strings = ("x", "10", "xyz", "007")
> Output: 10
>
> "x"   -> 1
> "xyz" -> 3
> "007" -> 7
> "10"  -> 10
> ```
>
> **Example 5**
>
> ```text
> Input: @strings = ("hello123", "2026", "perl")
> Output: 2026
>
> "hello123" -> 8
> "perl"     -> 4
> "2026"     -> 2026
> ```

Actually this can be solved with one simple line of code.

In a `map` call, a conditional operator (`?:`) with a regular expression of `/^\d+$/` as the condition determines whether there are only digits or not. Depending on that, each string (`$_`) is translated either into its numerical value (just `$_` itself) or into its length (with $_ being the default parameter).

That's all, here we go:

```perl
use v5.36;
use List::Util qw( max );

sub max_str_value( @strings ) {
    return max( map /^\d+$/ ? $_ : length, @strings );
}
```

## Task 2: Encrypted String

> You are given a string `$str` and an integer `$int`.<br/>
> Write a script to encrypt the string using the algorithm - for each character `$char` in `$str`, replace `$char` with the `$int`th character after `$char` in the alphabet, wrapping if needed and return the encrypted string.
>
> **Example 1**
>
> ```text
> Input: $str = "abc", $int = 1
> Output: "bcd"
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "xyz", $int = 2
> Output: "zab"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "abc", $int = 27
> Output: "bcd"
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "hello", $int = 5
> Output: "mjqqt"
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "perl", $int = 26
> Output: "perl"
> ```

I decided to add some additional requirements to this task:

* What if there are uppercase letters in the string?<br/>I think they should be encrypted the same way, but to an uppercase substitution.
* What if the string contains non-letter characters, like blanks or punctuation?<br/>I think they should be passed through without encryption.

My solution is bracketed by `split //` to separate the string into characters, and `join ""` to reassemble the translated characters. Within that bracket, a `map` code block does the translation itself.

For encrypting characters, it is necessary to know the ASCII value of the first alphabet character, which `'a'` and `'A'` for lower case and upper case letters, respectively. I use a variable `$start` for that, and as I don't like hard-coding these values, I use `ord( 'a'` or `'A' )`, depending on which of the regular expressions `/^[a-z]/` or `/^[A-Z]/` matches. If none of the two matcjes, we have a non-letter character, I want `$start` to be zero, to make it easier to *skip* the translation for non-letter characters. As the conditional expression is inside the `ord(...)` parameter list, I use a null character (`"\0"`) in the conditional expression, whose `ord` value is zero (as a number).

If we have a non-zero `$start` value, the translation according to the classical 'Caesar cypher' is this:

* The current character number is `ord( $_ ) - $start`,
* which is shifted by the 'key': `... + $int`,
* limited to the range 0..25: `( ... ) % 26`,
* added to the ASCII value (`$start`) of the first alphabet letter (`a` or `A`).
* This new ASCII value will be transformed into a character using `chr(...)`.

If the `$start` value is zero, we pass through the `$_` character as it is.

Definitely more than one line of code, but still only one statement (cheating a bit with the `map` code block...):   

```perl
use v5.36;

sub encrypted_string( $str, $int ) {
    return join "",
        map {
            my $start = ord( /^[a-z]/ ? 'a' : /^[A-Z]/ ? 'A' : "\0" );
            $start
            ? chr( $start + ( ord( $_ ) - $start + $int ) % 26 )
            : $_
        } split //, $str;
}
```

And, by the way:

**`"nbyqyyefswbuffyhay"`** is `encrypted_string( "theweeklychallenge", 358 )` ...



#### **Thank you for the challenge!**

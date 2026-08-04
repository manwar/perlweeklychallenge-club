# A Helpful Module and a Recursive Pattern

**Challenge 384 solutions in Perl by Matthias Muth**

## Task 1: Base N

> You are given a number and a base integer.<br/>
> Write a script to convert the given number in the given base integer.
>
> **Example 1**
>
> ```text
> Input: $num = 42, $base = 2
> Output: 101010
> ```
>
> **Example 2**
>
> ```text
> Input: $num = 15642094, $base = 16
> Output: EEADEE
> ```
>
> **Example 3**
>
> ```text
> Input: $num = 493, $base = 8
> Output: 755
> ```
>
> **Example 4**
>
> ```text
> Input: $num = 2228519, $base = 36
> Output: 1BRJB
>
> Base 36 uses numbers 0-9 and letters A-Z.
> ```
>
> **Example 5**
>
> ```text
> Input: $num = 123456789, $base = 64
> Output: 7MyqL
>
> Base 64 (using 0-9, A-Z, a-z, and extra symbols like + and /)
> ```

Not long ago, the was another challenge ([Challenge 379 Task 2 'Armstrong Number'](https://theweeklychallenge.org/blog/perl-weekly-challenge-379/#TASK2)) where we needed to convert numbers into different bases, too. What I took from solving that task, then, was that the `Math::Prime::Util` CPAN module contains a `todigits` function that returns the digits of a number $n$ in a given base $b$, as an array of integers (from $\{0,\dots,b-1\}$).

All that is left to do then is to translate those digits into the characters representing each digit in base $b$. This can be done with a substring lookup, using `map` to translate each digit into a single character, by using the digit as an index into an 'alphabet' string.

The task text and the examples give information about the 'alphabet' to use up to a base of 64. Larger bases will therefore be refused, as well as bases equal to or lower than 0.   

I don't think the following code needs much more explanation:

```perl
use v5.36;
use Math::Prime::Util qw( todigits );

sub base_n( $num, $base ) {
    return undef unless 0 < $base <= 64;
    my $digits = join "", 0..9, "A".."Z", "a".."z", "+", "/";
    return join "", map substr( $digits, $_, 1 ), todigits( $num, $base );
}
```

## Task 2: Special Binary Substrings

> You are given a binary string.<br/>
> Write a script to return all non-empty substrings (distinct) that have the same number of 0’s and 1’s, and all the 0’s and all the 1’s in these substrings are grouped consecutively.
>
> **Example 1**
>
> ```text
> Input: $binary = "0101"
> Output: ("01", "10")
> ```
>
> **Example 2**
>
> ```text
> Input: $binary = "000111"
> Output: ("000111", "0011", "01")
> ```
>
> **Example 3**
>
> ```text
> Input: $binary = "000011"
> Output:  ("0011", "01")
> ```
>
> **Example 4**
>
> ```text
> Input: $binary = "10011100"
> Output: ("10", "0011", "01", "1100")
> ```
>
> **Example 5**
>
> ```text
> Input: $binary = "00000"
> Output: ()
> ```

Very good, it's time to brush up my knowledge about recursive regular expressions a bit!

Let's first look at how to recognize a substring with `0` digits, followed by the same number of `1` digits (strings with `1`s followed by `0`s will be added later).

The shortest possible substring is `"01"`, and we recognize it with a pattern of `/01/`.

The next longer substring is `"0011"`, and we can group it like this: `/(0(01)1)/`.

For finding `"000111"`, a pattern with grouping could be  `/(0(0(01)1)1)/`.

Now we start to see a pattern (pun intended): It looks like after finding a `0`, we can recurse into the same pattern for finding more 'inner groups' before we match the final `1` on the same level.

The recursive pattern thus looks like this:

```perl
    / ( 0 (?-1)* 1 ) /x
```

The `(?-1)` part refers to the 'previous' parentheses group that was opened (hence the `-1`). That pattern can appear any number of times, so it is followed by the `*` quantifier.

An alternation helps to find both types of sequences, `0-1` as well as `1-0`:

```perl
     / ( 0 (?-1)* 1 ) | ( 1 (?-1)* 0 ) /x
```

For finding all occurrences, we cannot simply use the `//g` *global* option, because the substrings might overlap. We need to check the pattern starting at every possible position in the string, one by one. 

I see two options for doing that:

* Using `//g`, and setting the starting position for each search explicitly, using the `pos` function:

  ```perl
      my @results;
      for ( 0 .. length( $binary ) - 2 ) {
          pos( $binary ) = $_;
          if ( $binary =~ / ( 0 (?-1)* 1 ) | ( 1 (?-1)* 0 ) /gx ) {
              push @results, $&;
          }
      }
  ```

* Using `substr` to reduce the string to the part that is to be searched:

  ```perl
      my ( @results, %marked );
      for ( 0 .. length( $binary ) - 2 ) {
          if ( substr( $binary, $_ ) =~ / ( 0 (?-1)* 1 ) | ( 1 (?-1)* 0 ) /gx ) {
              push @results, $&;
          }
      }
  ```

I implemented both, and running a small benchmark, I found that the runtime is almost the same, with the `substr` version having a slight edge over the `pos` version.

I find that interesting, because I had imagined that repetitively building the substring needs a lot of copy operations. But it seems that the Perl optimizer does a great job there.

At the same time, I think that the `substr` version is easier to understand. So let's go with it.

Another point still needs to be addressed: The examples show that every match appears only once in the result list, while the code above does not eliminate possible duplicates.

Again, there are (at least) two options:

* using `uniq` from `List::Util` to reduce the result list,
* using a hash to mark the matches we already encountered, and skip their inclusion if they appear again.

Using `uniq` is the 'easy programming' option, which gives it an advantage.

Even more because another little benchmark shows that it is around 15% *faster* than the programmed out solution using a hash.

Again I would not necessarily have expected this, since there is a subroutine call overhead with `uniq`. But it seems that the `uniq` implementation is so highly optimized that this doesn't play a too big role.

This is the 'proof of concept' version of my solution:

```perl
use v5.36;

sub special_binary_substrings( $binary ) {
    my @results;
    for ( 0 .. length( $binary ) - 2 ) {
        push @results, $&
            if substr( $binary, $_ ) =~ / ( 0 (?-1)* 1 ) | ( 1 (?-1)* 0 ) /gx;
    }
    return uniq @results;
}
```

I then decided to replace the `for` loop by a call to `map`, and turn it into a one-statement solution:

```perl
use v5.36;
use List::Util qw( uniq );

sub special_binary_substrings( $binary ) {
    return uniq map {
        substr( $binary, $_ ) =~ / ( 0 (?-1)* 1 ) | ( 1 (?-1)* 0 ) /gx
        ? $&
        : ()
    } 0 .. length( $binary ) - 2;
}
```

#### **Thank you for the challenge!**

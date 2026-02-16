# Justifying TIMTOWTDI

**Challenge 360 solutions in Perl by Matthias Muth**

## Task 1: Text Justifier

> You are given a string and a width.<br/>
> Write a script to return the string that centers the text within that width using asterisks \* as padding.
>
> **Example 1**
>
> ```text
> Input: $str = "Hi", $width = 5
> Output: "*Hi**"
>
> Text length = 2, Width = 5
> Need 3 padding characters total
> Left padding: 1 star, Right padding: 2 stars
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "Code", $width = 10
> Output: "***Code***"
>
> Text length = 4, Width = 10
> Need 6 padding characters total
> Left padding: 3 stars, Right padding: 3 stars
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "Hello", $width = 9
> Output: "**Hello**"
>
> Text length = 5, Width = 9
> Need 4 padding characters total
> Left padding: 2 stars, Right padding: 2 stars
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "Perl", $width = 4
> Output: "Perl"
>
> No padding needed
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "A", $width = 7
> Output: "***A***"
>
> Text length = 1, Width = 7
> Need 6 padding characters total
> Left padding: 3 stars, Right padding: 3 stars
> ```
>
> **Example 6**
>
> ```text
> Input: $str = "", $width = 5
> Output: "*****"
>
> Text length = 0, Width = 5
> Entire output is padding
> ```

As usual, there are a lot of ways to solve this task. I chose the 'left-then-right' approach: In two steps, first add padding to the left, then add padding to the right.

The good thing about this approach is that the computation of how many padding characters need to be added are quite simple. But let's first discuss why this can be a 'problem' at all:

Already in the Example 1 (`$str = "Hi", $width = 5`), we learn that the result (`"*Hi**"`)  can have a different number of padding characters on the left and on the right. It seems that if there is an odd number of total padding characters to distribute, the odd character has to go to the right side, not to the left one.

The total number of number of padding characters is easy to compute:

```perl
    $width - length( $str )
```

If we split the padding to the left and right, we use half of them for each side:

```perl
    '*' x ( ( $width - length( $str ) ) / 2 )
```
If the total number is odd,
the expression `( $width - length( $str ) ) / 2`
includes a decimal part of 0.5.<br/>
Fortunately,
the `x` repetition operator only uses the integer part
of the second operand.
The fractional part is cut off implicitly.
This means that it is unnecessary to use `int( ... )` explicitly.

This also means that the expression above will give us the 'shorter' of the two parts if we have an odd number of padding characters to split. Therefore, it can *always* be used for the left-side padding:

```perl
    $str = "*" x ( ( $width - length( $str ) ) / 2 ) . $str;
```

After that, for the right side,
I don't rely on any even or odd computations
or on rounding up or down.
Once the left side has been padded, I simply recalculate what is needed for the right side based on the new length of `$str`, and append it:

```perl
    return $str . "*" x ( $width - length( $str ) );
```
In total, these two statements seem to be the easiest way for me:

```perl
use v5.36;

# Left-then-right approach.
sub text_justifier_LR( $str, $width ) {
    $str = "*" x ( ( $width - length( $str ) ) / 2 ) . $str;
    return $str . "*" x ( $width - length( $str ) );
}
```

In the code, I have also added several other implementations:

- An *iterative* approach, which adds single padding characters to the left or the right (depending on the even or odd current length of the string) until the desired length is reached.<br>Of course, this is the slowest of all approaches.

- An *insertion* approach, which creates a string of *all* padding characters, and then uses a 4-parameter `substr` call to insert the original string in the middle (no `int()` needed ;-) ).

- A *distribution* approach, which also creates a string of all padding characters, then prepends half of them to the original string, using `substr` to remove them from the padding string at the same time, and then appends the rest of the padding on the right.<br/>Maybe not the most clever solution either, shifting around characters multiple times.

- The *'once-and-done'* approach, which is basically the same as my 'left-then-right' solution described above, but only computing the length of the 'smaller' half of the padding, and then combining the left half, the original string and the right half all within the same statement.<br/>It turns out that this is the fastest of my solutions:

  ```perl
  # Once-and-done approach.
  sub text_justifier_in_one( $str, $width ) {
      my $n = ( $width - length( $str ) ) >> 1;
      return "*" x $n . $str . "*" x ( $width - length( $str ) - $n );
  }
  ```

## Task 2: Word Sorter

> You are give a sentence.<br/>
> Write a script to order words in the given sentence alphabetically but keeps the words themselves unchanged.
>
> **Example 1**
>
> ```text
> Input: $str = "The quick brown fox"
> Output: "brown fox quick The"
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "Hello    World!   How   are you?"
> Output: "are Hello How World! you?"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "Hello"
> Output: "Hello"
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "Hello, World! How are you?"
> Output: "are Hello, How World! you?"
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "I have 2 apples and 3 bananas!"
> Output: "2 3 and apples bananas! have I"
> ```

This task has a very straightforward 'Perlish' solution, using `split`, `sort` with a special code block, and `join`.

The code block for `sort` turns both strings into their 'folded case' versions, so that they can be sorted in lexical order.

```perl
use v5.36;

sub word_sorter( $str ) {
    return join " ", sort { fc $a cmp fc $b } split " ", $str;
}
```

Thanks a lot to fellow Weekly Challenge team members [Niels van Dijke](https://www.facebook.com/groups/theweeklychallengegroup/permalink/1570145197569545/), [Packy Anderson](https://packy.dardan.com/2026/02/12/perl-weekly-challenge-word-crimes-are-justified/) and [Matthew Neleigh](https://github.com/manwar/perlweeklychallenge-club/tree/master/challenge-360/mattneleigh/perl), from whose published solutions I have learned that the `fc` (*foldcase*) function is the correct function to use for case-independent character comparisons (I used `lc` *lowercase* before, which according to [perldoc](https://perldoc.perl.org/functions/fc) is not always correct.

Even with simple tasks, there is always something to learn, especially on the Weekly Challenge!

#### **Thank you for the challenge!**

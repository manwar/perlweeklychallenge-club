# Complex Squares
**Challenge 395 solutions in Perl by Matthias Muth**

## Task 1: Complex Number

> You are given two complex numbers as string.<br/>
> Write a script to return the multiplication of the given complex numbers.<br/>
> Using the formula: (a + bi) x (c + di) = (ac - bd) + (ad + bc)i
>
> **Example 1**
>
> ```text
> Input: $num1 = "1+1i", $num2 = "1+1i"
> Output: "0+2i"
> ```
>
> **Example 2**
>
> ```text
> Input: $num1 = "1+(-1)i", $num2 = "1+(-1)i"
> Output: "0+(-2)i"
> ```
>
> **Example 3**
>
> ```text
> Input: $num1 = "0+3i", $num2 = "0+4i"
> Output: "-12+0i"
> ```
>
> **Example 4**
>
> ```text
> Input: $num1 = "3+4i", $num2 = "3+(-4)i"
> Output: "25+0i"
> ```
>
> **Example 5**
>
> ```text
> Input: $num1 = "50+(-20)i", $num2 = "-10+30i"
> Output: "100+1700i"
> ```

This is a three-statement solution in a very classic structure:

* input processing,
* calculation,
* output.

For input processing, we have to extract the numeric values from the input strings that describe imaginary numbers. We don't care about anything around the numbers themselves, like the `+` sign, possible parentheses around negative values,  or whether the final `i` is present or not. A simple regular expression that extracts sequences of digits, possibly prefixed by a `-` sign for negative values, already does the job:

```perl
    my ( $a, $b, $c, $d ) = map /-?\d+/g, $num1, $num2;
```

Calculating the real and imaginary parts of the result follows the formula given in the task description:

 ```perl
     my ( $r, $i ) = ( $a * $c - $b * $d, $a *$d + $b * $c );
 ```

To return the result as a string, we need to add surrounding parentheses to the imaginary part if it is negative. A conditional expression is the easiest way to do that:

 ```perl
     return "$r+" . ( $i < 0 ? "($i)" : $i ) . "i";
 ```

So the complete solution is this:

```perl
use v5.36;

sub complex_number( $num1, $num2 ) {
    my ( $a, $b, $c, $d ) = map /-?\d+/g, $num1, $num2;
    my ( $r, $i ) = ( $a * $c - $b * $d, $a *$d + $b * $c );
    return "$r+" . ( $i < 0 ? "($i)" : $i ) . "i";
}
```

## Task 2: Word Squares

> You are given a list of equal lengths words.<br/>
> Write a script to arrange a set of words into a grid that reading across any row gives the exact same word as reading down its corresponding column.
>
> **Example 1**
>
> ```text
> Input: @words = ("MA", "AM", "MY", "ME")
> Output: ("MA", "AM")
>
>     M A
>     A M
> ```
>
> **Example 2**
>
> ```text
> Input: @words = ("SUN", "USE", "NET", "SEE", "TEN")
> Output: ("SUN", "USE", "NET")
>
>     S U N
>     U S E
>     N E T
> ```
>
> **Example 3**
>
> ```text
> Input: @words = ("BOAT", "TEAL", "AREA", "TSAR", "OGRE")
> Output: ("BOAT", "OGRE", "AREA", "TEAL")
>
>     B O A T
>     O G R E
>     A R E A
>     T E A L
> ```
>
> **Example 4**
>
> ```text
> Input: @words = ("CARD", "AREA", "REAR", "DART")
> Output: ("CARD", "AREA", "REAR", "DART")
>
>     C A R D
>     A R E A
>     R E A R
>     D A R T
> ```
>
> **Example 5**
>
> ```text
> Input: @words = ("HEART", "TREND", "EMBER", "RESIN", "ABUSE")
> Output: ("HEART", "EMBER", "ABUSE", "RESIN", "TREND")
>
>     H E A R T
>     E M B E R
>     A B U S E
>     R E S I N
>     T R E N D
> ```

This task is a bit more challenging (but that's what it's all about, isn't it?).

##### Recursive approach:

I build up the square row by row, starting with an empty square.

Once a word is chosen for the first row, we need to try to combine the rest of the words for the subsequent rows. This builds a tree of possible combinations. I use a recursive function to traverse that tree.

The function takes three parameters:

* a partially filled square (it may be empty for the initial call),
* the 'level' of the square, which is the number of rows that are already filled with words,
* the list of candidate words to fill into the other rows.

The function returns the first completely filled square once one is found. As we have a chain of recursion calls, one for each row to fill, once a complete square is found it is passed back up the chain.

Nothing is returned if the square cannot be completed with the remaining words. In that case, the calling function will try the next word.

##### Modeling a partially filled square:

Whenever a word is added to the square, it is put into the corresponding row. At the same time, the word's letters are added to the corresponding column. A partially filled square thus can look like this (taken from Example 5):

```perl
( "HEART",
  "EMBER",
  "AB",
  "RE",
  "TR" )
```

What is nice about this is that the partial words (like `"AB"`, `"RE"`, `"TR"`) can easily be used for checking whether any of the remaining words matches. For the row indexed with `$level`, a candidate matches if `$candidate =~ /^$rows->[$level]/` is true. For example `"ABUSE" =~ /^AB/` indicates a match of `"ABUSE"` for the next row in the example.

##### The solution:

This is the complete solution, consisting of the `fill_square` recursive function and the `word_squares` main function that does the initial call and directly returns the results.

I've kept the comments inside the code, hoping they'll help explain the details.

```perl
use v5.36;

sub fill_square( $rows, $level, $candidates ) {
    # Find the candidates that match in the next row.
    # For each one that does, add it to the square
    # and do a recursive call to fill the subsequent rows.
    # Return when we get back a fully filled square.
    for my $candidate ( $candidates->@* ) {
        # Only use this candidate if it fits with what already is
        # in the square. At level 0, every word fits, so this can
        # be shortcut.
        next unless $level == 0 || $candidate =~ /^$rows->[$level]/;

        # Use a copy of the original rows for the recursive calls,
        # so that own copy remains unchanged.
        my @rows = $rows->@*;
        $rows[$level] = $candidate;

        # Check the end condition.
        return @rows
            if $level == length( $rows[0] ) - 1;

        # Also add the candidate's letters in the appropriate column
        # in the rest of the rows.
        $rows[$_] .= substr( $candidate, $_, 1 )
            for $level + 1 .. length( $candidate ) - 1;

        # Do the recursive call.
        my @result =
            fill_square( \@rows, $level + 1,
                [ grep { $_ ne $candidate } $candidates->@* ] );
        return @result if @result;
        # If no result, try the next candidate.
    }
    return;
}

sub word_squares( @words ) {
    return fill_square( [], 0, [ @words ] );
}
```

#### **Thank you for the challenge!**

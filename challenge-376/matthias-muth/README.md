# A 1-Bit Chessboard and Fancy Separators

**Challenge 376 solutions in Perl by Matthias Muth**

## Task 1: Chessboard Squares

_Submitted by Mohammad Sajid Anwar_

> You are given two coordinates of a square on 8x8 chessboard.<br/>
> Write a script to find the given two coordinates have the same colour.
>
> ```text
> 8 W B W B W B W B
> 7 B W B W B W B W
> 6 W B W B W B W B
> 5 B W B W B W B W
> 4 W B W B W B W B
> 3 B W B W B W B W
> 2 W B W B W B W B
> 1 B W B W B W B W
> a b c d e f g h
> ```
>
> **Example 1**
>
> ```text
> Input: $c1 = "a7", $c2 = "f4"
> Output: true
> ```
>
> **Example 2**
>
> ```text
> Input: $c1 = "c1", $c2 = "e8"
> Output: false
> ```
>
> **Example 3**
>
> ```text
> Input: $c1 = "b5", $c2 = "h2"
> Output: false
> ```
>
> **Example 4**
>
> ```text
> Input: $c1 = "f3", $c2 = "h1"
> Output: true
> ```
>
> **Example 5**
>
> ```text
> Input: $c1 = "a1", $c2 = "g8"
> Output: false
> ```

Whether or not two squares share the same color can be determined by their 'Manhattan distance', which is simply the sum of their vertical distance and their horizontal distance. If this distance is even, the two squares are the same color.

Since we are only interested in whether the distance is even or odd, we only need to consider the least significant bit of the distance. In effect, we can perform 'one-bit arithmetic'.

In one-bit arithmetic, subtraction and addition are the same. Essentially, everything can be done using an XOR operation. Therefore, rather than first calculating the sums of the horizontal and vertical coordinates and then finding the difference between them, we can calculate the 'one-bit distance' (which represents a color change) by performing an XOR operation on all the coordinates and then checking the least significant bit.

How do we convert the coordinate strings like `"a7"` or `"f4"` into numerical coordinates? Thanks to the clever design of the ASCII code, the lower four bits of a digit code point represent its numerical value, while the lower five bits of a letter character represent its position in the alphabet. (For the letters `"a"` to `"h"` that we use here, this would even work in EBCDIC!).

As we will only consider the least significant bit in the end, we can perform XOR on the whole code points of all coordinate characters, without first stripping off the most significant bits. If the lowest bit is then `0`, the two fields are the same color.

And that's it:

```perl
use v5.36;

sub chessboard_squares( $c1, $c2 ) {
    my $dist = 0;
    $dist ^= ord( $_ )
        for split "", "$c1$c2";
    return ( $dist & 0x01 ) == 0;
}
```

## Task 2: Doubled Words

*Submitted by Matt Martini*

> You are given a string (which may contain embedded newlines) which is taken from a page on a website. The string will not contain brackets qw{ [ ] }.<br/>
> Write a script that will find doubled words (such as “this this”) and highlight (wrap in brackets) each doubled word.<br/>
> The script should:<br/>
>
> - Work across lines, even finding situations where a word at the end of<br/>
>   one line is repeated at the beginning of the next.<br/>
>   <br/>
> - Find doubled words despite capitalization differences, such as with<br/>
>   'The the...', as well as allow differing amounts of whitespace (spaces,<br/>
>   tabs, newlines, and the like) to lie between the words.<br/>
>   <br/>
> - Find doubled words even when separated by HTML tags. For example, to<br/>
>   make a word bold: '...it is <B>very</B> very important...'. Only show<br/>
>   lines containing doubled words.<br/>
>   <br/>
>   Adapted from Mastering Regular Expressions, Third Edition by Jeffrey E. F. Friedl
>
> **Example 1**
>
> ```text
> Input: $str = "you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing."
> Output: "web server for doubled words (such as '[this] [this]'), a common problem"
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words."
> Output: "Find doubled words despite capitalization differences, such as with '[The]\n[the]...', as well as allow differing amounts of whitespace (spaces,"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "to make a word bold: '...it is <B>very</B> very important...'."
> Output: "to make a word bold: '...it is <B>[very]</B> [very] important...'."
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "Perl officially stands for Practical Extraction and Report Language, except when it doesn't."
> Output: ""
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "There's more than one one way to do it.\nEasy things should be easy and hard things should be possible."
> Output: "There's more than [one] [one] way to do it."
> ```

The description gives a hint that the task is adapted from a book about Regular Expressions (Mastering Regular Expressions, Third Edition, by Jeffrey E. F. Friedl). This gives me confidence for finding a solution that uses regular expressions. So I try:

A 'word' is defined as a sequence of upper case and lower case characters. It has to start at what is considered a 'word boundary' in Perl regular expressions (`\b`). I would like to regard words containing an apostrophe as single words, too, and even composite words that contain a hyphen (`"-"`). So this is my definition of a 'word' for this task:

```perlI include 
    my $word_re = qr/\b[a-z'-]+\b/i;
```

For checking whether a word is repeated, I will use a 'back reference'. The first word is captured using parentheses, and the second word has to be the same. The `/i`  flag can be used to make ignoring case differences, as mandated. But this means that the first and the second word may actually be different. If we want to do a substitution later to surround them with square brackets, we need to keep each one in its original case, so we have to capture both separately.  So we get this regular expression structure to find duplicate words:

```perl
    /($word_re) <separator> (\g{1})/x
```

The `<separator>` is a placeholder for anything that can appear between the two words. Specifically, we must accept whitespace (including newlines, which are accepted as whitespace when we use the  `/s` flag), as well as tags such as `<B>` and `</B>`, and punctuation, such as commas and full stops. I go with this definition of a separator:

```perl  
    my $separator_re = qr/
        (?: <[^>]*> \s*     # tags
        | [[:punct:]] \s*   # punctuation
        |\s+                # whitespace
    )+ /sx;
```

With this definition, the regular expression looks like that now:

```perl
    /($word_re) ($separator_re) (\g{1})/xi
```

The 'separator' is captured, because we will reuse it in the substitution that follows: We surround both words by angle brackets, separated by what we have captured as a separator:

```perl
    $str =~ s/ ($word_re) ($separator_re) (\g{1}) /\[$1\]$2\[$3\]/xig;
```

Now we have marked all double words.

For the return value, we are supposed to only return lines that actually contain marked words.
I found it easiest to split the string into lines, the `grep` those lines that contain angle bracket markers, and reassemble those lines into a single string as a return value. Read it from right to left:

```perl
    return join "\n", grep /\[/, split "\n", $str;
```
So in the end, the whole solution consists of four statements: two variable declarations, more for clarity than out of necessity, one substitution, and a return statement that selects lines from the resulting string:
```perl
use v5.36;

sub doubled_words( $str ) {
    my $word_re = qr/ \b [a-z'-]+ \b /xi;
    my $separator_re = qr/ (?:
        <[^>]*> \s*             # tags
        | [[:punct:]] \s*       # punctuation
        |\s+                    # whitespace
    )+ /sx;
    $str =~ s/($word_re)($separator_re)(\g{1})/\[$1\]$2\[$3\]/ig;
    return join "\n", grep /\[/, split "\n", $str;
}
```

#### **Thank you for the challenge!**

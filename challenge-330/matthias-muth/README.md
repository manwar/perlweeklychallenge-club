# Capitalizing on Regular Expressions 

**Challenge 330 solutions in Perl by Matthias Muth**

## Task 1: Clear Digits

> You are given a string containing only lower case English letters and digits.<br/>
> Write a script to remove all digits by removing the first digit and the closest non-digit character to its left.
>
> **Example 1**
>
> ```text
> Input: $str = "cab12"
> Output: "c"
>
> Round 1: remove "1" then "b" => "ca2"
> Round 2: remove "2" then "a" => "c"
>```
> 
>**Example 2**
> 
>```text
> Input: $str = "xy99"
> Output: ""
> 
>Round 1: remove "9" then "y" => "x9"
> Round 2: remove "9" then "x" => ""
> ```
>
> **Example 3**
>
> ```text
>Input: $str = "pa1erl"
> Output: "perl"
> ```

Seems we need to remove pairs of non-digit and digit characters, repeatedly.

Not a big deal for regular expressions.<br/>
A substitution operator will do the removing, and as the result of that substitution indicates whether a replacement was found or not, it can serve as a loop condition, too.

As there is nothing else to be done, the loop will consist of the loop condition only, with an empty body. I like to put a comment into empty loops to make it obvious for the reader.

That

```perl
use v5.36;

sub clear_digits( $str ) {
    while ( $str =~ s/[a-z]\d// ) {
        # Everything is in the loop condition.
    }
    return $str;
}

```

## Task 2: Title Capital

> You are given a string made up of one or more words separated by a single space.<br/>
> Write a script to capitalise the given title. If the word length is 1 or 2 then convert the word to lowercase otherwise make the first character uppercase and remaining lowercase.
>
> **Example 1**
>
> ```text
> Input: $str = "PERL IS gREAT"
> Output: "Perl is Great"
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "THE weekly challenge"
> Output: "The Weekly Challenge"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "YoU ARE A stAR"
> Output: "You Are a Star"
> ```

The second task, too, is easily solved with a regular expression.

Here, I use three capture buffers:

* one for the first letter, which might have to be put into lower or uppercase  depending on the length of the word: `(\w)`
* one for a possible second character: `(\w?)`
* and one for the (possibly empty) rest of the word, from the third character to the end: `(\w*)`.

The third capture has a special role:<br/>
If it is empty, the whole word is only one or two characters long, and the first letter needs to be lowercase.<br/>
If it is non-empty, we need to uppercase the first letter.

The second and third captures will always be lowercased for the result.

My whole solution consists of a single substitution, with a `/e` option to evaluate the substitution part as an expression, a `/g` option to repeat the substitution as often as possible, and a `/r`  option to return the resulting final string instead of the number of substitutions done.<br/>
When I use the `/e` option, I put the expression into a pair of curly brackets, to give an optical hint that this is 'code' to be evaluated. I then use angle brackets for the pattern part.

So here we go: 

```perl
use v5.36;

sub title_capital( $str ) {
    return $str =~ s<(\w)(\w?)(\w*)>{
        ( $3 ? uc $1 : lc $1 ) . lc "$2$3"
    }egr;
}
```

#### **Thank you for the challenge!**

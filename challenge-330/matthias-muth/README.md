# Counter-Nice

**Challenge 329 solutions in Perl by Matthias Muth**

## Task 1: Counter Integers

> You are given a string containing only lower case English letters and digits.<br/>
> Write a script to replace every non-digit character with a space and then return all the distinct integers left.
>
> **Example 1**
>
> ```text
> Input: $str = "the1weekly2challenge2"
> Output: 1, 2
>
> 2 is appeared twice, so we count it one only.
>```
> 
>**Example 2**
> 
>```text
> Input: $str = "go21od1lu5c7k"
> Output: 21, 1, 5, 7
> ```
>
> **Example 3**
>
> ```text
>Input: $str = "4p3e2r1l"
> Output: 4, 3, 2, 1
> ```

Instead of *removing all non-digits* from the string, I will *extract all digits* instead, which will produce the same result.<br/>Using a regular expression like `/(\d+)/g` even helps to turn the sequences of digits into a list of numbers.

The examples suggest that the found numbers need to be returned in their original order, which is what we already have. We only need to remove duplicate entries, which a call to `uniq` does without changing the order.

So with the help of `util`, the solution is a one-liner:

```perl
use v5.36;
use List::Util qw( uniq );

sub counter_integers( $str ) {
    return uniq $str =~ /(\d+)/g;
}
```

## Task 2: Nice String

> You are given a string made up of lower and upper case English letters only.<br/>
> Write a script to return the longest substring of the give string which is nice. A string is nice if, for every letter of the alphabet that the string contains, it appears both in uppercase and lowercase.
>
> **Example 1**
>
> ```text
> Input: $str = "YaaAho"
> Output: "aaA"
>```
> 
>**Example 2**
> 
>```text
> Input: $str = "cC"
> Output: "cC"
> ```
>
> **Example 3**
>
> ```text
>Input: $str = "A"
> Output: ""
> 
> No nice string found.
>```

This one is a little bit more tricky.<br/>Let's 'divide and conquer':

1. We need to walk through all possible substrings of at least length 2.<br/>This means using a double loop, one for all possible starting positions, and the second one for all possible strings starting there, with varying lengths.<br/>
   I could not find any way to shortcut this, so I will use it even though its runtime behavior is more or less quadratic, which I dislike.
2. We need to find a maximum length substring.<br/>I will use a variable `$longest_nice` for that, initialized with the empty string (`""`) and updated from every substring that is longer *and* is a 'nice' string.
3. We need to decide whether a substring is a 'nice' string.<br/>For clarity, I will put this into a separate function `is_nice_string`.

Let's first concentrate on the implementation of that `is_nice_string` functon.

The task description says that a string is nice if '*for every letter of the alphabet that the string contains, it appears both in uppercase and lowercase*'. This does not require that any upper and lower case versions of the same character are next to each other, they can be anywhere in the string. For example: `"abcABC"` is as 'nice' a string as is `"aAbBcCa"`.

My solution is to create two strings:

* Extract all lowercase letters,
* remove duplicates,
* sort them alphabetically,
* and concatenate them into a 'normalized' string of the lowercase letters.

* Then do the same for the uppercase letters.


I put these two strings into `$lower` and `$upper`.

For example, the string `"YaaAho"` turns into the strings `"aho"` (lowercase) and `"AY"` (uppercase).<br/>`"aaAbBa"` turns into `"ab"` and `"AB"`.

Now, a string is a 'nice string' if the two resulting strings are the same, just in opposite case.<br/>
This can be checked with a simple comparison of `uc( $lower ) eq $upper`, which results in this implementation of `is_nice_string`:<br/>

```perl
use v5.36;
use List::Util qw( uniq );

sub is_nice_string( $str ) {
    my $lower = join "", sort +( uniq $str =~ /([a-z])/g );
    my $upper = join "", sort +( uniq $str =~ /([A-Z])/g );
    return uc( $lower ) eq $upper;
}
```

Note that I put those parentheses with a plus sign `+( ... )` around the `uniq` calls. This is a Perl language construct that is not needed very often, but which is very useful *when* it's needed.

If I just wrote `sort uniq $str =~ ...`, it would lead to a misinterpretation of `uniq` as being the comparison function for `sort`.  That won't work at all.

Putting the result of the  `uniq` call into `+(...)` parentheses shows the parser that the parentheses are used as the start of an expression (a *list* expression in that case), and not the start of the `sort` parameter list. The parser thus knows that the first parameter to `sort` is this list, and not a code block or a subroutine reference. No confusion anymore.

Apparently, the parser also doesn't get confused if *both* parameter sets, of `sort` and of `uniq`, are put in parentheses, like `sort( uniq( $str =~ ... ) )`. I actually cannot explain exactly why this doesn't work without the `sort` parameter list parentheses.

Both cases rely on the fact that the implicit (default) sorting order is using an alphanumeric comparison. So maybe it's also a good idea to just make this explicit: `sort { $a cmp $b } uniq $str =~ ...`.

To summarize (no, I'm not ChatGPT!):

```perl
    sort uniq $str =~ /([a-z])/g        # doesn't work!
    sort +( uniq $str =~ /([a-z])/g )   # ok.
    sort( uniq( $str =~ /([a-z])/g ) )  # ok.  
    sort { $a cmp $b } uniq $str =~ /([a-z])/g    # maybe the best, fully explicit.
```

The main subroutine then is rather straightforward. It contains an 'outer' loop for the starting position of possible substrings, and the 'inner' loop for checking all substrings of increasing length that start at that position, and remembering the longest 'nice' string found.

Yet, I have built in some shortcuts to avoid checking any substrings that are shorter than our current `$longest_nice` string and thus cannot at all be candidates for the longest nice string:

* Add a `$min_length` variable to hold the minimum length for any future substring to possibly become a `$longest_nice` string,
* end the outer loop when no substrings with a minimum length of `$min_length` can be extracted anymore,
* only extract substrings starting with a minimum length of `$min_length` in the inner loop,
* don't forget to update `$min_length` whenever a longer `$longest_nice` string is found.

The main subroutine then looks like this, concluding my solution:

```perl
sub longest_nice_substring( $str ) {
    my ( $start, $longest_nice, $min_length ) = ( 0, "", 2 );
    while ( $start + $min_length <= length( $str ) ) {
        for my $len ( $min_length .. length( $str ) - $start ) {
            my $substr = substr( $str, $start, $len );
            if ( is_nice_string( $substr )  {
                $longest_nice = $substr;
                $min_length = length( $longest_nice ) + 1;
            }
        }
        ++$start;
    }
    return $longest_nice;
}
```

Exercise done, lessons learned!

#### **Thank you for the challenge!**

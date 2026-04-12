# Big, Big and Little

**Challenge 368 solutions in Perl by Matthias Muth**

## Task 1: Make it Bigger

> You are given a given a string number and a character digit.<br/>
> Write a script to remove exactly one occurrence of the given character digit from the given string number, resulting the decimal form is maximised.
>
> **Example 1**
>
> ```text
> Input: $str = "15456", $char = "5"
> Output: "1546"
>
> Removing the second "5" is better because the digit following it (6) is
> greater than 5. In the first case, 5 was followed by 4 (a decrease),
> which makes the resulting number smaller.
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "7332", $char = "3"
> Output: "732"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "2231", $char = "2"
> Output: "231"
>
> Removing either "2" results in the same string here. By removing a "2",
> we allow the "3" to move up into a higher decimal place.
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "543251", $char = "5"
> Output: "54321"
>
> If we remove the first "5", the number starts with 4. If we remove the
> second "5", the number still starts with 5. Keeping the largest possible
> digit in the highest place value is almost always the priority.
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "1921", $char = "1"
> Output: "921"
> ```

To explain the reasoning behind my solution, let's assume that one occurrence of the digit `5` is to be removed, for example.

* If there is a `5` that is followed by a *larger* digit (`6`to `9`), it is best to remove that `5`, because the larger digit will take its place, resulting in a bigger number.
* If there are several `5`s followed by a larger digit, it is best to remove the first one. This is because replacing a `5` with a larger digit in a position of greater significance is always better than replacing it in a position of lesser significance, regardless of the values of the digits involved. This is what is described in the explanation of Example 4.
* If there is no `5` that is followed by a larger digit, there are only lower digits to take the place of a `5`. In that case, it is best to let this happen in the position with the *lowest* significance. In other words, the *last* possible `5` should be removed. Actually this also covers the case where the `5` is the last digit overall.

So there are only two steps needed to get the biggest possible number with `$char` removed:

1. Remove the first occurrence of `$char` that is followed by a digit that is larger than `$char`.
2. If no such occurrence exists, remove `$char` at the last possible position.

I use regular expressions to translate these two steps into Perl.

1. For removing an occurrence of `$char` followed by a larger digit, I use a little trick: I construct a character range from `0` to $char, which includes all digits that are *not* larger, and use that in a negative lookahead:

   ```perl
       s/ $char (?! [0-${char}] ) //x
   ```

2. If that fails, removing the last occurrence of `$char` can be done with the following pattern, which finds `$char`,  followed by any number of characters that are *not* `$char`, up to the end of the string:

   ```perl
       s/ ${char} (?= [^${char}]* $ )//x
   ```

Putting it together results in a concise solution: 

```perl
use v5.36;

sub make_it_bigger( $str, $char ) {
    $str =~ s/ $char (?! [0-${char}] ) //x
        || $str =~ s/ ${char} (?= [^${char}]* $ )//x;
    return $str;
}
```

## Task 2: Big and Little Omega

> You are given a positive integer \$number and a mode flag \$mode. If the mode flag is zero, calculate little omega (the count of all distinct prime factors of that number). If it is one, calculate big omega (the count of all prime factors including duplicates).
>
> **Example 1**
>
> ```text
> Input: $number = 100061
>        $mode = 0
> Output: 3
>
> Prime factors are 13, 43, 179. Count is 3.
> ```
>
> **Example 2**
>
> ```text
> Input: $number = 971088
>        $mode = 0
> Output: 3
>
> Prime factors are 2, 2, 2, 2, 3, 20231. Count of distinct numbers is 3.
> ```
>
> **Example 3**
>
> ```text
> Input: $number = 63640
>        $mode = 1
> Output: 6
>
> Prime factors are 2, 2, 2, 5, 37, 43. Count including duplicates is 6.
> ```
>
> **Example 4**
>
> ```text
> Input: $number = 988841
>        $mode = 1
> Output: 2
> ```
>
> **Example 5**
>
> ```text
> Input: $number = 211529
>        $mode = 0
> Output: 2
> ```

Another one-statement solution, but with a big help from `Math::Prime::Util` and `List::Util`.

Getting the prime factors of `$number` is delegated to the `factor` function from `Math::Prime::Util`. Actually, that function already returns the number of prime factors when it is called in scalar context, so we get the Big Omega without even counting ourselves, and possibly with some optimization within the function itself.

For Little Omega, we do produce the list of prime factors using the same function, and pass it through `uniq` to remove duplicates, and the use the number of elements in the list as returned by `scalar`.

So the whole solution can be as short as this:

```perl
use v5.36;

use Math::Prime::Util qw( factor );
use List::Util qw( uniq );

sub big_and_little_omega( $number, $mode ) {
    return
        $mode == 1
        ? scalar factor( $number )
        : scalar uniq factor( $number );
}
```

#### **Thank you for the challenge!**

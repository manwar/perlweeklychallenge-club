# Inside Out and Round We Go

**Challenge 390 solutions in Perl by Matthias Muth**

## Task 1: Decode String

> You are given an encoded string.<br/>
> Write a script to return the decoded string of the given encoded string.<br/>
> The encoding rule is: K[encoded_string], where the encoded_string inside the square brackets is repeated exactly K > 0 times.
>
> **Example 1**
>
> ```text
> Input: $str = "2[3[a]]"
> Output: "aaaaaa"
>
> 3[a]    => aaa
> 2[3[a]] => aaa aaa
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "10[a]"
> Output: "aaaaaaaaaa"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "a2[b]c3[d]e"
> Output: "abbcddde"
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "2[a2[b]c]"
> Output: "abbcabbc"
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "1[a]2[b3[c]]"
> Output: "abcccbccc"
> ```

The task is very similar to a recent task ([Week 387 Task 2 'Atoms Count'](https://theweeklychallenge.org/blog/perl-weekly-challenge-387/#TASK2)). Then, there were atom groups, each consisting of a parenthesized sequence of  atoms or other atom groups, followed by a multiplier. Here, the position of the multiplier and the group is reversed: the multiplier comes first, followed by a bracketed group of letters or other letter groups. In both tasks, the goal is to turn the multiplier groups into repeated sequences of the characters in the respective group.

In both cases, it is tempting to use a recursive approach. When a multiplier and an opening square bracket is encountered, we can extract everything inside the bracket pair, up to the matching closing square bracket. Then we do a recursive call with the extracted string, to resolve possible further multiplier groups contained within.

The only thing is that 'extracting everything up to the matching square bracket' is a recursive task itself. Probably, the method of choice would be a recursive regular expression. So while it sounds simple, it may turn out more complicated than necessary, in terms of coding effort as well as in terms of runtime.

But there's a simpler solution. While the recursive solution works outside-in, we might consider working inside-out: Let's first find and resolve simple multiplier groups that do not contain other groups. The simple groups looks like `<multiplier>[<letters>]`. As a regular expression:

```perl
    / (\d+) \[ ([[:alpha:]]*) \] /x 
```

After matching this against `$str`, the captures `$1` and `$2` contain the multiplier and the sequence of letters, respectively. We can use a `s///` substitution to replace the simple group by the repeated sequence:

```perl 
    $str =~ s< (\d+) \[ ([[:alpha:]]*) \] >{ $2 x $1 }xe;
```

The `/e` (_evaluate_) flag is used, so that instead of using it as a simple replacement string,  the second part of the substitution is evaluated as Perl code that returns an expression. Within that expression, we then can use the `x` string repetition operator to obtain the repeated sequence of characters that we need.

I always use curly brackets `{` and `}` when I use the `/e` flag, to give a visual clue that this is 'code'. As a consequence, I have to use paired delimiters for the first part, too, and there I choose `<` and `>`.

For the complete solution, we just have to do that substitution repeatedly. The `/g`(_global_) flag handles all simple groups that can be found within the string. We then repeat the substitution as long as there are other, enclosing groups. The substitution itself also provides the end condition for that outer loop: when no more simple groups can be found, the substitution fails and the loop terminates. Everything is contained in the loop condition, so that actually the loop has an empty body. I put in a comment to make this more visible.

This is the complete code:

```perl
use v5.36;

sub decode_string( $str ) {
    while ( $str =~ s< (\d+) \[ ([[:alpha:]]*) \] >{ $2 x $1 }xeg ) {
        # Everything is in the loop condition.
    }
    return $str;
}
```

## Task 2: Order Characters

> You are given a string $s (containing only alphabetic characters) and an integer $k > 0.<br/>
> Write a script to choose one of the first $k letters of given string and append it at the end of the string. You keep doing this until you have lexicographically smallest string and return the string.
>
> **Example 1**
>
> ```text
> Input: $str = "dbca", $k = 1
> Output: "adbc"
>
> Move 1: "bcad"
> Move 2: "cadb"
> Move 3: "adbc"
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "geeks", $k = 2
> Output: "eegks"
>
> First 2 letters: "g", "e"
>
> Move 1: "gekse" (move second letter "e")
> Move 2: "gksee" (move second letter "e")
> Move 3: "kseeg"
> Move 4: "seegk"
> Move 5: "eegks"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "cbaed", $k = 3
> Output: "abcde"
>
> First 3 letters: "c", "b", "a"
>
> Move 1: "cbeda"  (move "a")
> Move 2: "cedab"  (move "b")
> Move 3: "edabc"  (move "c")
> Move 4: "eabcd"  (move "d")
> Move 5: "abcde"  (move "e")
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "fedcba", $k = 4
> Output: "abcdef"
>
> First 4 letters: "f", "e", "d", "c"
>
> Move 1: "fdcbae" (move "e")
> Move 2: "dcbaef" (move "f")
> Move 3: "dcbefa" (move "a")
> Move 4: "dcefab" (move "b")
> Move 5: "defabc" (move "c")
> Move 6: "efabcd" (move "d")
> Move 7: "fabcde" (move "e")
> Move 8: "abcdef" (move "f")
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "perl", $k = 1
> Output: "erlp"
>
> Move 1: "erlp" (move "p")
> ```
>
> **Example 6**
>
> ```text
> Input: $str = "oloolooo", $k = 1
> Output: "looloooo"
> ```
>
> **Example 7**
>
> ```text
> Input: $str = "oloooolo", $k = 1
> Output: "looloooo"
> ```

Let's consider first the case of `$k >= 2`. 

Having at least two characters to choose from means that we can eventually reorder the string completely, into any order we like. We can, for example, repeatedly choose the lowest character among the first `$k` characters and move it to the end. We may need several complete rotations of the string, but we can eventually move the characters into any desired order.

The important observation is that, with two or more choices available, there is no restriction on the final ordering of the characters. 

What this means is that we don't really have to implement that 'sorting algorithm'. What is important is that we *know* that we can *always* obtain the lowest possible string when we have at least two characters to choose from.

This means that we are not limited to the type of sorting explained in the task description, and we do not necessarily have to execute the same steps as shown in the examples. Instead, we can choose *any* sorting algorithm to get the final result: the string that contains all characters from `$str` in ascending order.

So let's keep it simple:

```perl
    return join "", sort split "", $str
        if $k >= 2;
```

Next, let's have a look at the `$k == 1` case.

With `$k == 1`, we don't have much choice. We can only `rotate` the whole string, without being able to change the order of characters.

Examples 6 and 7 are interesting for the `$k == 1` case. They show that it is not enough to simply find the 'lowest' character in the string and rotate the string so that that character becomes the first one. While this works for Example 6, it doesn't work for Example 7:

In both examples, the lowest character is `l`. Rotating the string to bring that character upfront results in `looloooo` in Example 6, which is the correct solution.

In Example 7, however, rotating the string to have the first `l` upfront results in `looooloo`, but this is  not the correct solution. The correct solution is `looloooo`, just as in Example 6.

What we really need to do for `$k == 1` is to generate all **cyclic rotations** of the string, and then find the lowest among them.

Actually that is not very complicated, either. Using `map` to generate the rotated strings, and `minstr` from `List::Util` to get the 'lowest' string, it can look like this:

```perl
    return minstr( map substr( $str, $_ ) . substr( $str, 0, $_ ),
            0 .. length( $str ) - 1 )
        if $k == 1;
```

The first `substr` takes everything from the rotation point to the end, while the second takes everything before the rotation point. Concatenating the two gives one cyclic rotation for each possible rotation point.

Putting the two cases together actually results in a one-statement solution:

```perl
use v5.36;
use List::Util qw( minstr );

sub order_characters( $str, $k ) {
    return
        $k >= 2
        ?  join "", sort split "", $str
        : minstr( map substr( $str, $_ ) . substr( $str, 0, $_ ),
            0 .. length( $str ) - 1 );
}
```

Who would have thought!

#### **Thank you for the challenge!**

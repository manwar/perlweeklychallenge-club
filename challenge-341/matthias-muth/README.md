# (Pre-)Fix what is Broken

**Challenge 341 solutions in Perl by Matthias Muth**

## Task 1: Broken Keyboard

> You are given a string containing English letters only and also you are given broken keys.<br/>
> Write a script to return the total words in the given sentence can be typed completely.
>
> **Example 1**
>
> ```text
> Input: $str = 'Hello World', @keys = ('d')
> Output: 1
>
> With broken key 'd', we can only type the word 'Hello'.
> ```
>
> **Example 2**
>
> ```text
> Input: $str = 'apple banana cherry', @keys = ('a', 'e')
> Output: 0
> ```
>
> **Example 3**
>
> ```text
> Input: $str = 'Coding is fun', @keys = ()
> Output: 3
>
> No keys broken.
> ```
>
> **Example 4**
>
> ```text
> Input: $str = 'The Weekly Challenge', @keys = ('a','b')
> Output: 3
> ```
>
> **Example 5**
>
> ```text
> Input: $str = 'Perl and Python', @keys = ('p')
> Output: 1
> ```

Perl's regular expressions help to find a concise solution for this task.<br/>But the main goal for me this time isn't shortness, it's readability.

This could have been my short solution:

```perl
sub broken_keyboard_short_and_ugly( $str, $keys ) {
    scalar grep ! $keys->@* || ! /[$keys->@*]/i, split " ", $str;
}
```

(Assuming `use v5.36` or whatever you prefer for having  `strict`, `warnings`, and `feature signatures`.)

Don't worry, there's no need to dive into it to see what it does. I will explain later for those who are curious.

Here is my 'real' solution.<br/>
This one is much clearer, I hope:

```perl
use v5.36;

sub broken_keyboard( $str, $keys ) {
    my @words = split " ", $str;
    return scalar @words
        if ! $keys->@*;
    my $keys_concat = join "", $keys->@*;
    return scalar grep ! /[$keys_concat]/i, @words;
}
```

The concept is the same, only that this code can almost be read as its own description in English:

* 
  Split up the input string into words, using any amount of whitespace as separator<br/>(the `" "` special case for the `split` separator does that perfectly):<br/>
  `    my @words = split " ", $str;`
* Return the full number of words if there are no broken keys.<br/>
  `    return scalar @words`<br/>`         if ! $keys->@*;`
* Build a string with the concatenated broken key characters<br/>(we will see in the next step what that will be used for):<br/>
  `     my $keys_concat = join "", $keys->@*;`
* Return the count of words that do not(!) match a regular expression with a bracketed character class containing all broken keys, ignoring upper or lower case.<br/>
  `    return scalar grep ! /[$keys_concat]/i, @words;`<br/>
   (`grep` in scalar context returns the number of hits instead of the hits themselves.)

There are chances that even I will understand what I wrote when I stumble over this code in a year or so...

But just for the curious, here is what the 'short' version does.<br/>Basically the same thing just mapped into one single statement, but with a fews pitfalls:

* For keeping the code short, the `grep` condition contains both cases of having broken keys or not.<br/>It is assumed that any word is a hit if there are no keys (`! $keys->@*`) or -- if there are -- the word does not match the regular expression containing the character class with the list of broken keys.<br/>Clearly, there is a runtime punishment for this. The check whether we have any broken keys is repeated for every word.
* Watch out: In the regular expression, the *array* is interpolated into the character class (not a string, as in the other solution).<br/>This results in all array elements being put in, separated by space characters. Similar to using `"$keys->@*"` in double quoted strings.<br/>But that means that our character class also contains space characters. So actually we are not only looking for broken keys in the words, but also for space characters!<br/>
  Good that we know there cannot be any...

So to understand the code fully, the reader also has to understand these specialties. Any changes to the code can be surprising...

This is why I didn't use my shortest solution for this task.<br/>I hope you agree.

## Task 2: Reverse Prefix

> You are given a string, \$str and a character in the given string, \$char.<br/>
> Write a script to reverse the prefix upto the first occurrence of the given \$char in the given string \$str and return the new string.
>
> **Example 1**
>
> ```text
> Input: $str = "programming", $char = "g"
> Output: "gorpmming"
>
> Reverse of prefix "prog" is "gorp".
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "hello", $char = "h"
> Output: "hello"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "abcdefghij", $char = "h"
> Output: "hgfedcbaj"
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "reverse", $char = "s"
> Output: "srevere"
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "perl", $char = "r"
> Output: "repl"
> ```

Now this is the task where I fully promote a short solution!<br/>
A single regular expression substitution is all that is needed:

```perl
use v5.36;

sub reverse_prefix( $str, $char ) {
    return $str =~ s<^.*?$char>{ reverse $& }er;
}
```

Explanation?

Everything from the beginning of the string up to and including the first `$char` character is matched:<br/>`     /^.*?$char/`<br/>The 'everything' match is 'non-greedy' (`.*?`), so that it stops when the first `$char` is found.

The replacement for the prefix is generated with `reverse $&`. That's why the substitution part is an evaluated expression (code), using the `/e` flag.<br/>It's a habit of mine to put the code part into curly brackets when I use the `/e` flag, to make it more visible.<br/>
I then use a pair of angle brackets for the first part.

The `/r` flag returns the resulting string (instead of the number of matches found).<br/>That's the subroutine's return value, and that's all.

 This is Perl. Not everything short is bad! 

**Thank you for the challenge!**

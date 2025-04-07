# Finding Things in Things

**Challenge 315 solutions in Perl by Matthias Muth**

## Task 1: Find Words

> You are given a list of words and a character.<br/>
> Write a script to return the index of word in the list where you find the given character.
>
> **Example 1**
>
> ```text
> Input: @list = ("the", "weekly", "challenge")
>        $char = "e"
> Output: (0, 1, 2)
>```
> 
>**Example 2**
> 
>```text
> Input: @list = ("perl", "raku", "python")
>     $char = "p"
>    Output: (0, 2)
> ```
>
> **Example 3**
>
> ```text
>Input: @list = ("abc", "def", "bbb", "bcd")
>     $char = "b"
> Output: (0, 2, 3)
>    ```

The solution to this task can be as short as one line, but let's first think about how to approach it.

The result needs to be a list of indices. So one approach can be to create the complete list of indices, then reduce it to only those entries that we want. Let's see where this leads us.

So first, the complete list of indices. If the parameters to our subroutine are `$list` and `$char`, with `$list` being a *reference* to the array of words, then traditionally, this is the list of indices into the words:

```perl
    0..$#$list
```

I am using 'Modern Perl' constructs wherever I can, because most of the time it's easier to re-understand whenever I come back to the code after time.
The other times I do it to be consistent.

Here, to give me the list of indices, I use:

- the `keys` function to return the indices of an array (since Perl 5.12),
- the *postfix dereference syntax* (since Perl 5.20 as a feature, always enabled since Perl 5.24):

```perl
    keys $list->@*
```

Next, we restrict the indices to those that match the condition. That means `grep` of course.

The word at the given index (`$list->[$_]`) has to contain the `$char` character.<br/>
There can't be a more obvious use for a regular expression:

```perl
    grep $list->[$_] =~ /$char/, keys $list->@*
```

Oops! We are already finished!<br/>We just need to return that list. So this is the complete solution:

```perl
use v5.36;

sub find_words( $list, $char ) {
    return grep $list->[$_] =~ /$char/, keys $list->@*;
}
```

## Task 2: Find Third

> You are given a sentence and two words.<br/>
> Write a script to return all words in the given sentence that appear in sequence to the given two words.
>
> **Example 1**
>
> ```text
> Input: $sentence = "Perl is a my favourite language but Python is my favourite too."
>           $first = "my"
>           $second = "favourite"
> Output: ("language", "too")
>```
> 
>**Example 2**
> 
>```text
> Input: $sentence = "Barbie is a beautiful doll also also a beautiful princess."
>        $first = "a"
>           $second = "beautiful"
>    Output: ("doll", "princess")
> ```
>
> **Example 3**
>
> ```text
>Input: $sentence = "we will we will rock you rock you.",
>        $first = "we"
>        $second = "will"
>    Output: ("we", "rock")
>    ```

My idea here is to walk through the list of words, and for each word to check whether the previous two words are `$first` and `$second`. Obviously I have to start with the third word.

So the first thing I do is to separate the sentence into an array of words. The typical `split " ", $sentence` won't work here, because it will keep the punctuation characters with the words, which we don't want. So I use a global (`/g`) regular expression.

Considering that someone might use this with a language other than English, we should use a 'Unicode-aware' pattern instead of the typical `/[a-zA-Z]+/`.  Then our solution will also work with an example containing a (German) sentence like this:

> ```text
> Input: $sentence = "Das ist so schön, weil das so schön ist!"
>        $first = "so"
>        $second = "schön"
> Output: ("weil", "ist")
> ```

So this is how I split the sentence into words:

```perl
    my @words = $sentence =~ /([[:alpha:]]+)/g;
```

After that, I can directly return the words that match, using a chain of `grep` on the indices (starting from `2`, for the third word) and `map` to map the matching indexes into the corresponding words for the result list.

So here is the whole thing:

```perl
use v5.36;

sub find_third( $sentence, $first, $second ) {
    my @words = $sentence =~ /([[:alpha:]]+)/g;
    return
        map $words[$_],
            grep $words[ $_ - 2 ] eq $first && $words[ $_ - 1 ] eq $second,
                2..$#words;
}
```

#### **Thank you for the challenge!**

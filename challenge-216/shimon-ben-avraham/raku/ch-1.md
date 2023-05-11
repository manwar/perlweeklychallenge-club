```raku
#! /usr/bin/env raku

# Perl Weekly Challenge #216, Challenge 1
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Thu 11 May 2023 05:53:06 PM EDT
# Version 0.0.1

# always use the latest version of Raku
use v6.*;
```

TITLE
=====



Task 1: Registration Number
===========================

SUBTITLE
========



Submitted by: Mohammad S Anwar
------------------------------

You are given a list of words and a random registration number.

Write a script to find all the words in the given list that has every letter in the given registration number.

### Example 1

    Input: @words = ('abc', 'abcd', 'bcd'), $reg = 'AB1 2CD'
    Output: ('abcd')

The only word that matches every alphabets in the given registration number is 'abcd'.

### Example 2

    Input: @words = ('job', 'james', 'bjorg'), $reg = '007 JB'
    Output: ('job', 'bjorg')

### Example 3

    Input: @words = ('crack', 'road', 'rac'), $reg = 'C7 RA2'
    Output: ('crack', 'rac')

SOLUTION
========



```raku
multi MAIN (Str $reg, *@words) {
    my Str @result;
```

We're going to use the `comb` method to determine if any of the input words fulfill the requirements. 

First, remove all the non-alphabetics from the registration number.

```raku
    my Junction $reg-letters = $reg.subst(/<-alpha>/, :g)
```

We don't care about the case of the letters.

```raku
        .lc
```

Now create an array of the letters remaing in the registration number.

```raku
        .comb
```

Create an `any` junction from the letters.

```raku
        .any;
```

In example 3, above, `$reg-letters` will be 

```raku
any("a", "r", "c")
```

Now, collect the words that match the registration in the `@result` array.

```raku
    @result.push($_) if
```

We don't care about the case of the words being tested.

```raku
        .lc
```

Here's the heart of the algorithm. `comb` the word with the previously made `Junction`. This will create a `Junction` of *n* `Seq`uences, where *n* is the number of letters in the registration number. 

```raku
        .comb($reg-letters)
```

When we `comb` the words in the third example, we will get these `Junction`s:

```raku
# for "crack"
any(("c", "c").Seq, ("r",).Seq, ("a",).Seq)

# for "road"
any(().Seq, ("r",).Seq, ("a",).Seq)

# for "rac"
any(("c",).Seq, ("r",).Seq, ("a",).Seq)
```

The word "road" does not meet the challenge's requirements, because it lacks the letter 'c'. This is reflected in the empty `Seq`uence: 

```raku
().Seq
```

The other two examples pass the requirements, and so do not include an empty `Seq`uence in their `any Junction`s. =end pod

so to find the good words, match the `Junction` against an empty list; those that **don't** match are the good ones.

```raku
    !~~ ()
```

Finally, make sure we test every word in the `@words` array...

```raku
        for @words;
```

...and print the results!

```raku
    say @result.List;
} # end of multi MAIN (Str $reg, *@words)

#| Run with the option '--test' to test the program
multi MAIN (Bool :$test!) {
    use Test::Output;

    output-is {samewith('AB1 2CD', <abc abcd abd>)}, "(abcd)\n", 'Example 1 OK';
    output-is {samewith('007 JB', <job james bjorg>)}, "(job bjorg)\n", 'Example 2 OK';
    output-is {samewith('C7 RA2', <crack road rac>)}, "(crack rac)\n", 'Example 3 OK';
}
```

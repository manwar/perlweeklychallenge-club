# Uncommonly Recursive

**Challenge 385 solutions in Perl by Matthias Muth**

## Task 1: Uncommon Words

> You are given two sentences.<br/>
> Write a script to return list of all uncommon words, order is not important.
>
> **Example 1**
>
> ```text
> Input: $sentence1 = "apple banana apple"
>        $sentence2 = "banana orange"
> Output: ("orange")
> ```
>
> **Example 2**
>
> ```text
> Input: $sentence1 = "cat dog"
>        $sentence2 = "bird fish"
> Output: ("cat", "dog", "bird", "fish")
> ```
>
> **Example 3**
>
> ```text
> Input: $sentence1 = "the quick brown fox"
>        $sentence2 = "the quick"
> Output: ("brown", "fox")
> ```
>
> **Example 4**
>
> ```text
> Input: $sentence1 = "hello"
>        $sentence2 = "hello"
> Output: ()
> ```
>
> **Example 5**
>
> ```text
> Input: $sentence1 = "blue blue red"
>        $sentence2 = "red green green yellow"
> Output: ("yellow")
> ```

I interpret *uncommon words* as *words that the two sentences do not have in common*. In other words, they are words that occur in one sentence but not in the other.

For me, the easiest way to solve the task is to count how often each word occurs across the two sentences. All *uncommon* words should then have a count of 1.

But wait. What happens if the same word appears twice in the same sentence, but not in the other one? One could argue that such a word is not 'common', because it does not appear in both sentences. Yet the word count for this word will be greater than 1.

But Example 5 gives an important clue. We have `blue` appearing twice in the first sentence, `green` appearing twice in the second one, and `red` appearing in both. Thus `blue`, `green`, and `red` all have a frequency of 2, while `yellow` has a frequency of 1. Since `yellow` is the only word in the expected result, this confirms that a frequency of 1 is indeed the correct criterion. It doesn't seem to matter *why* a word has frequency 2 (whether it occurs twice in one sentence or once in each sentence), it is excluded from the result.

For count the occurrences for every word, I use `frequency` from `List::MoreUtils`. It returns a hash in which for every key, its value indicates how often that key appeared in the input list.

`split " "` splits a sentence at whitespace. For the list of all words, I use `map` to apply this to both `$sentence1` and `$sentence2`.

For the final result, `grep` selects those words whose frequency is exactly 1.

```perl
use v5.36;
use List::MoreUtils qw( frequency );

sub uncommon_words( $sentence1, $sentence2 ) {
    my %freq = frequency map { split " " } $sentence1, $sentence2;
    return grep { $freq{$_} == 1 } keys %freq;
}
```

Testing this solution requires a little effort.

For typical challenge tasks, it is enough to compare the result with an expected value (or list of values). Here, though, the return value is a list of hash keys. Perl randomizes the order in which hash keys are returned between runs, for security reasons.

We could sort the result list before returning it, but the task description explicitly tells us that 'the order is not important', so we shouldn't take more effort than needed and waste CPU cycles for sorting.

But `Test2::V0` has an answer for this: We can use a *bag builder* if the expected elements may occur in any order. The `bag` function creates a check object that can be used with `is` to compare to our subroutine output (wrapped into an array reference) with the expected elements. The *bag* can be set up to pass the test if all the expected elements are present, regardless of their order, and no other elements are present.

Of course it only makes sense to use a `bag` if there is more than one expected element to check. For a single word, a simple arrayref containing that word is enough, as is an empty arrayref if no value is expected at all. Therefore, a `bag` is used only for Examples 2 and 3.

This is the testing code that tests the task examples:

```perl
use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", ["apple banana apple", "banana orange"],
        ["orange"] ],
    [ "Example 2", ["cat dog", "bird fish"],
        bag { item $_ for "cat", "dog", "bird", "fish"; end } ],
    [ "Example 3", ["the quick brown fox", "the quick"],
        bag { item $_ for "brown", "fox"; end } ],
    [ "Example 4", ["hello", "hello"],
        [] ],
    [ "Example 5", ["blue blue red", "red green green yellow"],
        ["yellow"] ],
);

is [ uncommon_words( $_->[1]->@* ) ], $_->[2], $_->[0]
    for @tests;

done_testing;
```

## Task 2: Outermost Parentheses

> You are given a valid parentheses string.<br/>
> Write a script to return the string after removing the outermost parentheses of every primitive string in the primitive decomposition of the given string.
>
> **Example 1**
>
> ```text
> Input: $str = "()()()"
> Output: ""
>
> Primitive Decomposition: "()" + "()" + "()"
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "(((())))"
> Output: "((()))"
>
> Primitive Decomposition: "(((())))"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "(()())(())"
> Output: "()()()"
>
> Primitive Decomposition: "(()())" + "(())"
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "()((()))()"
> Output: "(())"
>
> Primitive Decomposition: "()" + "((()))" + "()"
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "(()(()))(()())"
> Output: "()(())()()"
>
> Primitive Decomposition: "(()(()))" + "(()())"
> ```

Cool, another task that can be solved with a recursive regular expression!

The 'Primitive Decomposition' seems to split the input string into a sequence of balanced-parentheses strings. Each 'primitive' starts with an opening parenthesis and ends with a closing one, and it contains an 'inner part' that, again, is a balanced-parentheses string. So, actually, the task is to remove the enclosing parentheses at the outermost level of every primitive.

Let's start with constructing a pattern that accepts one such 'primitive', capturing the inner part:

```perl
    / \( ( <inner part> ) \) /x
```

The escaped parentheses, `\(` and `\)`, match literal parentheses. The unescaped parentheses, `(` and `)`, delimit a capture group.

As said before, the inner part is a balanced-parentheses string (which can be empty, actually). This is where we can apply the recursion, because the outer parentheses already match the first level of a balanced sequence. We can apply the complete pattern for the recursion to match the inner part.

`(?R)` recursively invokes the entire regular expression, allowing the inner part to contain arbitrarily nested balanced parentheses. Since the inner part can contain zero or more complete balanced-parentheses groups, we use `(?R)*`.

```perl
    / \( ( (?R)* ) \) /x
```

Having captured the inner part, we can use a `s///` substitution to replace the whole match by `$1`, thereby removing the outer parentheses while leaving the inner part untouched.

Since there may be several primitives in sequence, we use the `/g` *global* flag to perform the substitution on all of them in one statement.

And as we want to directly return the resulting string after all the substitutions, we can use the `/r` (*result*) flag to that effect.

The 'Primitive Decomposition' and the removal of the outer parentheses are entirely handled by the recursive regular expression in the substitution. The subroutine itself does not need any explicit recursion or looping.

In effect, it turns out to be a one-statement solution!

```perl
use v5.36;

sub outermost_parentheses( $str ) {
    return $str =~ s/ \( ( (?R)* ) \) /$1/xgr;
}
```

#### **Thank you for the challenge!**


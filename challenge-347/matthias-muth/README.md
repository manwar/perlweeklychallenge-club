# Recursive Parentheses - But no Recursive Magic

**Challenge 346 solutions in Perl by Matthias Muth**

This week, I am sorry to only have a solution for Task 1. 

## Task 1: Longest Parenthesis

> You are given a string containing only ( and ).<br/>
> Write a script to find the length of the longest valid parenthesis.
>
> **Example 1**
>
> ```text
> Input: $str = '(()())'
> Output: 6
>
> Valid Parenthesis: '(()())'
> ```
>
> **Example 2**
>
> ```text
> Input: $str = ')()())'
> Output: 4
>
> Valid Parenthesis: '()()' at positions 1-4.
> ```
>
> **Example 3**
>
> ```text
> Input: $str = '((()))()(((()'
> Output: 8
>
> Valid Parenthesis: '((()))()' at positions 0-7.
> ```
>
> **Example 4**
>
> ```text
> Input: $str = '))))((()('
> Output: 2
>
> Valid Parenthesis: '()' at positions 6-7.
> ```
>
> **Example 5**
>
> ```text
> Input: $str = '()(()'
> Output: 2
>
> Valid Parenthesis: '()' at positions 0-1 and 3-4.
> ```

This task is a good showcase for recursive regular expressions.<br/>Recursive regular expressions are not used too often, that's why I even guess that not every Perl programmer knows about their existence. I also had to look up the details in [perldoc](https://perldoc.perl.org/perlre#(?PARNO)-(?-PARNO)-(?+PARNO)-(?R)-(?0)). 

Constructing that regular expression, I start with a pair of parentheses. I use the `/x` modifier to be able to use whitespace within the pattern for easier reading. 

```perl
    $str =~ / \(  \) /x
```

Now within these parentheses,  the pattern is supposed to accept an optional other pair of parentheses, and inside that one again, which gives us the point where to insert the recursion pattern `(?R)?` . The ending `?` makes it optional to have subgroups of parentheses:

```perl
    $str =~ / \( (?R)? \) /x
```

But we also need to be able to accept a string like `'(()()())'`, which contains several parentheses groups in a row. We can do that by simply replacing the ending `?` by an ending `*`, to have zero, one or any number  of parentheses groups there:

```perl
    $str =~ / \( (?R)* \) /x
```

Example 3 shows us that we also need to accept several groups of parentheses following each other directly on the first level, like in `'((()))()'`. So let's put what we have into a (non-capturing) group, of which we need to have at least one, but possibly many, so `(?: ... )+`:

```perl
    $str =~ / (?: \( (?R)* \) )+ /x
```

In the end, we are supposed to return the length of the longest match. So let's add a `/g` *global* option to the regex to get all matches as a list, then use `map` and `length` to transform that list of matches into a list of their lengths, and then pass that list as parameters to the `max` function (from `List::Util`) to get the proper result:

```perl
use v5.36;
use List::Util qw( max );

sub longest_parenthesis( $str ) {
    return max( map length, $str =~ / (?: \( (?R)* \) )+ /xg );
}
```

That wasn't too difficult, was it?

## Task 2: Magic Expression

Seems I was too ambitious to find a recursive solution for Task 2 that does not evaluate every term from scratch for all the possible combinations.<br/>
To my own disappointment I was not able to finish it in time.

Sorry for having no solution for Task 2 this week.



#### **Thank you for the challenge!**

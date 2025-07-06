# Regexes Replacing All Good Strings?

**Challenge 328 solutions in Perl by Matthias Muth**

## Task 1: Replace all ?

> You are given a string containing only lower case English letters and ?.<br/>
> Write a script to replace all ? in the given string so that the string doesn’t contain consecutive repeating characters.
>
> **Example 1**
>
> ```text
> Input: $str = "a?z"
> Output: "abz"
> 
> There can be many strings, one of them is "abz".
> The choices are 'a' to 'z' but we can't use either 'a' or 'z' to replace the '?'.
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "pe?k"
> Output: "peak"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "gra?te"
> Output: "grabte"
> ```

It would be strange *not* to think of regular expressions
when a task is to replace parts of a string
with something else.<br/>
So regex it is!

Let's first have a look at the replacement character.<br/>
I will replace all question marks with the letter `'a'`,
except if one of the letters to the left or right of the question mark
already is an `'a'`.<br/>
In that case, I will use `'b'` as the replacement.<br/>
If the question mark's neighbors are
both an `'a'` and a `'b'` (or a `'b'` and an `'a'`),
I will use a `'c'`.<br/>
This should avoid all possible cases of 'consecutive repeating characters'.<br/>
With `$left` and `$right` being the left and right neighbors, respectively,
a possible formula to determine the correct replacement is as follows.
It minimizes the number of comparisons that need to be done: 

```perl
            $left eq "a"    ? ( $right eq "b" ? "c" : "b" )
            : $right eq "a" ? ( $left eq "b" ? "c" : "b" ) : "a";
```

The plan is to use the `s///` substitution operator
to find each question mark
and replace it with the correct replacement character.
Since we have a formula,
it is best to use a `/e` *execute* option for the substitution,
which allows us to use a piece of code
(containing the above formula) to compute the replacement.
I like to put code pieces into curly brackets when I use the `/e` option,
so it will be more like a `s[...]{...}/e` substitution.
The `[` and `]` are not for starting a character class,
but the most practical way to to delimit the matching pattern
with delimiter pairs. 

Now let's construct the regular expression for that 'matching' part.<br/>
We need to find a question mark, plus its neighbors on the left and right.
I will therefore use `\?` as the pattern,
and a *look-behind* for the left neighbor
and a *look-ahead* for the right neighbor.
Both shall match *any* single character,
but I will *capture* them for use in the formula.

I then add some `|` alternatives.
One for getting an empty match for the left neighbor
when the question mark appears directly at the beginning of the string,
and similarly one for getting an empty match for the right neighbor
when the question mark is at the end.

I add the `/x` option to allow for visually structuring of the matching pattern,
and the `/g` option to perform all substitutions at once.

Since all work  is completed after that statement is executed,
I also add the `/r` option to directly return the resulting string.

This is the complete substitution statement:

``` perl
    $str =~
        s[ (?<=(^|.)) \? (?=(.|$)) ] {
            my ( $left, $right ) = ( $1, $2 );
            $left eq "a"    ? ( $right eq "b" ? "c" : "b" )
            : $right eq "a" ? ( $left eq "b"  ? "c" : "b" ) : "a";
        }xegr;
```

The only small problem with that is that that look-behind pattern
`(?<=(^|.))` causes a warning:

```text
Variable length positive lookbehind with capturing is experimental in regex: [...]
```

But it works perfectly for all tests and examples,
so when your have at least Perl 5.30
(in which variable length look-behinds were first implemented),
just switching off that warning should be OK.<br/>
That's what I do for my complete solution:

```perl
use v5.30;
use feature 'signatures';
no warnings 'experimental::signatures';

sub replace_all_questionmarks( $str ) {
    no warnings 'experimental::vlb';
    $str =~
        s[ (?<=(^|.)) \? (?=(.|$)) ] {
            my ( $left, $right ) = ( $1, $2 );
            $left eq "a"    ? ( $right eq "b" ? "c" : "b" )
            : $right eq "a" ? ( $left eq "b"  ? "c" : "b" ) : "a";
        }xegr;
}
```


## Task 2: Good String

> You are given a string made up of lower and upper case English letters only.<br/>
> Write a script to return the good string of the given string. A string is called good string if it doesn’t have two adjacent same characters, one in upper case and other is lower case.
>
> **Example 1**
>
> ```text
> Input: $str = "WeEeekly"
> Output: "Weekly"
> 
> We can remove either, "eE" or "Ee" to make it good.
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "abBAdD"
> Output: ""
> 
> We remove "bB" first: "aAdD"
> Then we remove "aA": "dD"
> Finally remove "dD".
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "abc"
> Output: "abc"
> ```

Using regular expressions *again*!

For this task, as we may have overlapping patterns,
we can not just do all substitutions at once using the `/g` option.
Instead, we need a 'real' loop.

But the loop body can be empty,
because the substitution itself does the job *and* delivers
the ending condition for the loop.

How do we construct the regular expression here?<br/>
We need something that fulfills both criteria:
The *same character*, but in *different case*.

For the *same character* criteria,
we can use the idiomatic *backreference* technique,
capturing a character,
then referencing what we captured using `\g{-1}` for example.
But I do not know any way of using a backreference and saying that it has to be in a different case at the same time.

But what we can do is to make sure that the *different case* criteria
is already fulfilled  when we capture the first letter.
We can use a *lookahead* to make sure that the following letter is in different case
*without knowing what the letter actually is*.
For any lower case letter that we capture,
we can use a *lookahead* to ascertain that the next letter is in uppercase,
and vice versa for uppercase letters.<br/>
Like this, for example:

```perl
    / ( [a-z](?=[A-Z]) | [A-Z](?=[a-z]) ) /x
```

Now we have captured a lower case letter
of which we know that that is followed by an uppercase letter,
or an uppercase letter
of which we know that it is followed by a lowercase letter.<br/>
Note that for sure we *must not* give a `/i` (*ignore case*) option for this to work.

Now we need to make sure that the two letters are the same
*when case is ignored*.<br/>
But didn't we just said we *cannot* ignore case, for the capture to work?<br/>
Yes, we did, but we can do it anyway:
the magic spell is  `(?i)`.<br/>
It switches on the *ignore case* option for the rest of the pattern,
so in our case, for matching the backreference.

So here we go, with a nice short regex solution:

```perl
sub good_string( $str ) {
    while ( $str =~ s/( [a-z](?=[A-Z]) | [A-Z](?=[a-z]) ) (?i)\1 //x ) {
        # Everything is in the loop condition.
    }
    return $str;
}
```


#### **Thank you for the challenge!**

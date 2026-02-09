# Loops Considered

**Challenge 359 solutions in Perl by Matthias Muth**

## Task 1: Digital Root

> You are given a positive integer, $int.<br/>
> Write a function that calculates the additive persistence of a positive integer and also return the digital root.<br/>
> Digital root is the recursive sum of all digits in a number until a single digit is obtained.<br/>
> Additive persistence is the number of times you need to sum the digits to reach a single digit.
>
> **Example 1**
>
> ```text
> Input: $int = 38
> Output: Persistence  = 2
>         Digital Root = 2
>
> 38 => 3 + 8 => 11
> 11 => 1 + 1 => 2
> ```
>
> **Example 2**
>
> ```text
> Input: $int = 7
> Output: Persistence  = 0
>         Digital Root = 7
> ```
>
> **Example 3**
>
> ```text
> Input: $int = 999
> Output: Persistence  = 2
>         Digital Root = 9
>
> 999 => 9 + 9 + 9 => 27
> 27  => 2 + 7 => 9
> ```
>
> **Example 4**
>
> ```text
> Input: $int = 1999999999
> Output: Persistence  = 3
>         Digital Root = 1
>
> 1999999999 => 1 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 => 82
> 82 => 8 + 2 => 10
> 10 => 1 + 0 => 1
> ```
>
> **Example 5**
>
> ```text
> Input: $int = 101010
> Output: Persistence  = 1
>         Digital Root = 3
>
> 101010 => 1 + 0 + 1 + 0 + 1 + 0 => 3
> ```

We need a counter for the number of reductions
that we apply to our `$int` input.<br/>
Its naming is obvious to me, I will call it `$persistence`. 

And we need a formula to build the checksum of a number.<br/>
For me, this one works well: `sum( split //, $int )`.

Then, it's a short loop that does all the work:

```perl. But ipsum dolor sit amet...
    ( $int = sum( split //, $int ), ++$persistence )
        while $int > 9;
```

As short as it is,
there are some things I think are worth considering with this loop:

* The loop is implemented using a `while` *statement modifier*.<br/>
This is a Perl construct that often is useful
to produce clear and concise code,
because it avoids the overhead of writing a full lexical block
with curly braces around the code and parentheses around
the `if`, `unless`, `while` or `until` condition.<br/>
So for a simple statement this can often be preferred.

  But writing a statement
  using a `while` or `until` statement modifier
  (which goes *after* the statement) comes with a catch:<br/>
  Is the loop body executed even when the condition is false
  from the beginning?<br/>
  Very clear answer: It depends!

  Normally, the condition is evaluated first,
  and the statement is skipped if the condition is false,
  which is the right thing to do in most cases,
  and helps to write concise code.

  BUT!
  If the statement is a `do { ... }` block,
  that block is executed *at least* once
  before the condition is evaluated
  (with good reasons explained in
  [perldoc](https://perldoc.perl.org/perlsyn#Statement-Modifiers)!).

  What that means in our case is that writing

  ```perl
      do { $int = sum( split //, $int ); ++$persistence }
          while $int > 9;
  ```

  would be WRONG,
  because the `$persistence` counter would  be incremented
  even if `$int` only has one digit from the start.

* But there is a way to avoid the  `do { ... }`,
  even if we need several statements within the loop body.<br/>
  It is based on the fact that in Perl,
  every statement can also be used as an expression.<br/>
  We can turn the assignment and the auto-increment *statements*
  into a *list of expressions*,
  separating them by commas instead of semicolons.<br/>
  And to make it clearer that there is more than one expression
  on that line, we can surround them with parentheses.

In combination, we get a short, 'elegant' loop.

This is how it looks inside the complete code:

```perl
use v5.36;
use List::Util qw( sum );

sub digital_root( $int ) {
    my $persistence = 0;
    ( $int = sum( split //, $int ), ++$persistence )
        while $int > 9;
    return ( $persistence, $int );
}
```

## Task 2: String Reduction

> You are given a word containing only alphabets,<br/>
> Write a function that repeatedly removes adjacent duplicate characters from a string until no adjacent duplicates remain and return the final word.
>
> **Example 1**
>
> ```text
> Input: $word = "aabbccdd"
> Output: ""
>
> Iteration 1: remove "aa", "bb", "cc", "dd" => ""
> ```
>
> **Example 2**
>
> ```text
> Input: $word = "abccba"
> Output: ""
>
> Iteration 1: remove "cc" => "abba"
> Iteration 2: remove "bb" => "aa"
> Iteration 3: remove "aa" => ""
> ```
>
> **Example 3**
>
> ```text
> Input: $word = "abcdef"
> Output: "abcdef"
>
> No duplicate found.
> ```
>
> **Example 4**
>
> ```text
> Input: $word = "aabbaeaccdd"
> Output: "aea"
>
> Iteration 1: remove "aa", "bb", "cc", "dd" => "aea"
> ```
>
> **Example 5**
>
> ```text
> Input: $word = "mississippi"
> Output: "m"
>
> Iteration 1: Remove "ss", "ss", "pp" => "miiii"
> Iteration 2: Remove "ii", "ii" => "m"
> ```

For reducing duplicate characters,
I use a `s///` substitution using a regular expression.
The regular expression itself uses a *backreference*
to match a second character when it is equal to the first one,
which has to be captured for that.
The substitution part is empty,
because we want to remove both characters:

```perl
    s/(.)\g-1//
```

Example 2 contains cases 'nested' pairs of characters.
A simple `/g` *global* modifier is not enough
to remove these nested pairs,
so we have to work 'inside out',
trying the substitution again
until no pairs are found anymore.
We need a loop around the substitution!

The `s///` returns the number of substitutions actually made.
This means that it both does the job
*and* can serve as the condition for when to stop.
We will have a condition, but no code in the loop body itself.
Another interesting loop!

The most explicit way to write an 'empty' loop like that
probably is this one:

```perl
    while ( s/(.)\g-1// ) {
        # Everything is in the loop condition.
    }
```

This is self-documenting,
and helpful for the programmer
who is supposed to understand this when he or she reads it
(which is yourself most of the time,
after some time has passed and your train of thought has faded).

But here, I am using a shortcut.<br/>
Just like in the previous task,
I will use a *statement modifier* to write the loop.
And the statement itself can be anything
that does not have any effect.
The shortest form probably is this one:

```perl
    1 while s/(.)\g-1//;
```

Now this for me is so short that it already requires
a second thought again when reading it.<br/>
I use a *slightly* more self-explaining version in my actual solution:

```perl
use v5.36;

sub string_reduction( $word ) {
    do {} while $word =~ s/(.)\g-1//g;
    return $word;
}
```

Note that I also added a tiny optimization
in adding that `/g` *global* option
even if it is not strictly necessary.
It helps to do as many substitutions as possible
within one execution before looping back again,
hopefully reducing the startup cost of the regex engine
if we *don't* have nested pairs of letters.  

Actually, this solution is exactly identical to my solution of
'Challenge 340 Task 1: Duplicate Removals'...
😉

#### **Thank you for the challenge!**

# Buddy's Last Word

**Challenge 331 solutions in Perl by Matthias Muth**

## Task 1: Last Word

> You are given a string.<br/>
> Write a script to find the length of last word in the given string.
>
> **Example 1**
>
> ```text
> Input: $str = "The Weekly Challenge"
> Output: 9
>```
> 
>**Example 2**
> 
>```text
> Input: $str = "   Hello   World    "
> Output: 5
> ```
>
> **Example 3**
>
> ```text
>Input: $str = "Let's begin the fun"
> Output: 3
> ```

This looks so complicated, and it is so easy...<br/>
We let 

```perl
    split " ", $str
```
do the separation into words.
The good thing is that with `" "` as a separator parameter,
`split` ignores leading and trailing whitespace, so the
```perl
    "   Hello   World    "
```
example still results in `( "Hello", "world" )`.<br/>
Then we take the last word of the resulting word list, like
```perl
    ( split " ", $str )[-1]
```
If we didn't find any words at all, the list will be empty,
and the `(...)[-1]` will return `undef`.<br/>
We can use the `//` *defined or* operator to turn that `undef`
into an empty string,
so that we can use the `length` function on what we have:
```perl
    length( ( split " ", $str )[-1] // "" )
```
This makes the solution a one-liner:

```perl
use v5.36;

sub last_word_length( $str ) {
    return length( ( split " ", $str )[-1] // "" );
}
```

## Task 2: Buddy Strings

> You are given two strings, source and target.<br/>
> Write a script to find out if the given strings are Buddy Strings.<br/>
> If swapping of a letter in one string make them same as the other then they are `Buddy Strings`.
>
> **Example 1**
>
> ```text
> Input: $source = "fuck"
>        $target = "fcuk"
> Output: true
>
> The swapping of 'u' with 'c' makes it buddy strings.
>```
> 
>**Example 2**
> 
>```text
> Input: $source = "love"
>     $target = "love"
>    Output: false
> ```
>
> **Example 3**
>
> ```text
>Input: $source = "fodo"
>     $target = "food"
> Output: true
>    ```
> 
>**Example 4**
> 
>```text
> Input: $source = "feed"
>    $target = "feed"
> Output: true
> ```

This one is a bit more tricky, and I deal with it step by step.

##### First step: Check correct length.

If the `$source` and `$target` strings have different lengths,
it will never be possible to transform one into the other
by flipping characters, so I return `false` in that case:

```perl
    return false
        unless length( $source ) == length( $target );
```
I then can safely assume that the strings *do* have the same length
in the rest of the code.

##### Second step: Find differing pairs 
I compare the strings character by character,
by first creating pairs of characters at the same position,
and then selecting only those where the two characters are not the same.
Example:
```text
$source:       f             o             o             d
$target:       f             o             d             o
@pairs:      ( [ "f", "f" ], [ "o", "o" ], [ "o", "d" ], [ "d", "o" ] )
@diff_pairs: (                             [ "o", "d" ], [ "d", "o" ] )
```
I use the well-known `split //, STRING`
for turning  the strings into lists of characters,
and I put both lists into anonymous arrays.
For creating pairs from those arrays,
I use `zip` (from `List::Util`),
which combines elements from the array-refs given as parameters
into short arrays for each position.
Next, I `grep` through the pairs,
selecting only those where the two characters differ:
```perl
    my @pairs = zip [ split "", $source ], [ split "", $target ];
    my @diff_pairs = grep $_->[0] ne $_->[1], @pairs;
```

##### Third step: Recognize Buddy Strings

Strings are *Buddy Strings* if we can swap two letters in one string
and get the other string.
This is only possible if:

* there are exactly two differing pairs,
  and their letters are the same, only in different order<br/>
  ('Standard Buddies'),

or (as per Example 4):

* the strings are completely equal,
  but there is at least one letter that is contained at least twice,
  so that we can swap the letter with itself<br/>
  ('Equal Buddies').

##### Standard Buddies

The first criteria translates into this:
```perl
    return true
        if @diff_pairs == 2
            && $diff_pairs[0][0] eq $diff_pairs[1][1]
            && $diff_pairs[0][1] eq $diff_pairs[1][0];
```
If this didn't find us any 'Standard Buddies', we check for 'Equal Buddies'. 

##### Equal Buddies

The strings have to be equal,
but instead of comparing the two strings letter by letter,
there's a shortcut:
we have already compiled a list of differing pairs,
so having *no* differing pairs is the same as the strings being equal:
```perl
    return false
        unless @diff_pairs == 0;
```

For checking whether there is a character that is contained at least twice,
the 'elegant' solution would use a self-referencing regular expression:
```perl
    $source =~ /(.).*\g1/;
```
(We can restrict ourselves to one of the two strings,
because they are equal.)<br/>
So the final return could actually look like this:
```perl
    return @diff_pairs == 0 && $source =~ /(.).*\g1/;
```

But as usual, I am a bit concerned about the quadratic runtime behavior
of this regular expression for very long strings
(which of course we don't have in the examples!).
The regex engine must walk through the rest of the string
for every single character,
and then backtrack and do the same for the next one,
resulting in a maximum of ${n(n+1)}\over{2}$ comparisons.

So I resort to a linear approach,
remembering which letters the string contains
and returning `true` the moment a letter is found
that has already been seen:

```perl
    return false
        unless @diff_pairs == 0;
    my %seen;
    for ( split "", $source ) {
        return true
            if $seen{$_}++;
    }
    return false;
```

The complete solution:

```perl
use v5.36;
use builtin qw( true false );
use List::Util qw( zip );

sub buddy_strings( $source, $target ) {
    # Check for equal lengths.
    return false
        unless length( $source ) == length( $target );

    # Extract pairs of differing characters.
    my @pairs = zip [ split "", $source ], [ split "", $target ];
    my @diff_pairs = grep $_->[0] ne $_->[1], @pairs;

    # Detect 'Standard' Buddies.
    return true
        if @diff_pairs == 2
            && $diff_pairs[0][0] eq $diff_pairs[1][1]
            && $diff_pairs[0][1] eq $diff_pairs[1][0];

    # Detect 'Equal' Buddies containing at least one repeated character. 
    return false
        unless @diff_pairs == 0;
    my %seen;
    for ( split "", $source ) {
        return true
            if $seen{$_}++;
    }
    return false;
}
```

Nice challenge!

#### **Thank you for the challenge!**

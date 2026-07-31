# Similar Words and Similar Colors

**Challenge 383 solutions in Perl by Matthias Muth**

## Task 1: Similar List

> You are given three list of strings.<br/>
> Write a script to find out if the first two list are similar with the help the third list. The third list contains the similar words map.
>
> **Example 1**
>
> ```text
> Input: $list1 = ("great", "acting")
>        $list2 = ("fine", "drama")
>        $list3 = (["great", "fine"], ["acting", "drama"])
> Output: true
> ```
>
> **Example 2**
>
> ```text
> Input: $list1 = ("apple", "pie")
>        $list2 = ("banana", "pie")
>        $list3 = (["apple", "peach"], ["peach", "banana"])
> Output: false
> ```
>
> **Example 3**
>
> ```text
> Input: $list1 = ("perl4", "python")
>        $list2 = ("raku", "python")
>        $list3 = (["perl4", "perl5", "raku"])
> Output: true
> ```
>
> **Example 4**
>
> ```text
> Input: $list1 = ("enjoy", "challenge")
>        $list2 = ("love", "weekly", "challenge")
>        $list3 = (["enjoy", "love"])
> Output: false
> ```
>
> **Example 5**
>
> ```text
> Input: $list1 = ("fast", "car")
>        $list2 = ("quick", "vehicle")
>        $list3 = (["quick", "fast"], ["vehicle", "car"])
> Output: true
> ```

What we need to decide whether the words in `$list1`
and the ones in `$list2` are 'similar' is a *thesaurus* --
a list of words where each word has a list of other words
that have the same or similar meaning.
Our thesaurus will be built from the arrayrefs in `$list3`.

Every arrayref in `$list3` can be seen as
representing a 'similarity class'.
For looking up whether a word is in that similarity class,
the list is transformed into an 'existence hash'.
The reference to this hash is then used
to create a thesaurus entry for each word in the list.

As the thesaurus itself is implemented as a hash,
we can check whether two words are similar
by simply checking whether a hash entry for the second word
exists in the first word's hash-ref.

To illustrate this, using data from Example 1,
this is how the thesaurus for the first 'similarity class' is set up:

```perl
    $thesaurus{"great"} = { "great" => 1, "fine" => 1 };
    $thesaurus{"fine"}  = { "great" => 1, "fine" => 1 };        
```

Then, both of

```perl
    $thesaurus{"great"}{"fine"}
    $thesaurus{"fine"}{"great"}
```

are true.

For setting up the thesaurus,
each arrayref in `$list3` is mapped to several hash entries,
one for each word in that list.
Actually, as all of these words are in the same 'similarity class',
they can share the same hashref.
So in the `map` body, the 'inner hash' is created first.
Then, the key-value pairs for all word entries are produced:

```perl
    my %thesaurus = map {
        my %similarity_class = map { ( $_ => 1 ) } $_->@*;
        map { ( $_ => \%similarity_class ) } $_->@*;
    } $list3->@*;
```

With the thesaurus in place,
we then can check whether all words sharing the same index
in `$list1` and `$list2` are either equal or 'similar'.

If the words are equal, we don't need to look up any similarity,
and actually there might not even be a 'similarity class'
for a single word (like for `"python"` in Example 3).

The loop that walks through the two lists uses a multi-variable loop,
together with the `mesh` function from `List::Util`.

I like the readability of the code with this construct.
Multi-variable `for`/` foreach` loops were introduced in Perl v5.36,
which is my current 'minimum' Perl version
because of all the nice and 'modern' features that are included.

```perl
use v5.36;
use builtin qw( true false );
no warnings 'experimental::builtin';

use List::Util qw( mesh );

sub similar_list( $list1, $list2, $list3 ) {
    # Build a thesaurus for similar words.
    my %thesaurus = map {
        my %similarity_class = map { ( $_ => 1 ) } $_->@*;
        map { ( $_ => \%similarity_class ) } $_->@*;
    } $list3->@*;

    # Now check whether all words in the two lists are the same or similar.
    for my ( $word1, $word2 ) ( mesh $list1, $list2 ) {
        return false
            unless $word1 eq $word2
              || $thesaurus{ $word1 }{ $word2 };
    }
    return true;
}

```

## Task 2: Nearest RGB

> You are given a 6-digit hex color.<br/>
> Write a script to round the RGB channels to the nearest web-safe value and return the nearest RGB color.<br/>
> 00 (0), 33 (51), 66 (102), 99 (153), CC (204) and FF (255)
>
> **Example 1**
>
> ```text
> Input: $color = "#F4B2D1"
> Output: "#FF99CC"
>
> Red: F4 (Decimal 244), closer to 255 => FF
> Green: B2 (Decimal 178), closer to 153 => 99
> Blue: D1 (Decimal 209), closer to 204 => CC
> So the nearest RGB: "#FF99CC"
> ```
>
> **Example 2**
>
> ```text
> Input: $color = "#15E6E5"
> Output: "#00FFCC"
>
> Red: 15 (Decimal 21), closer to 0 => 00
> Green: E6 (Decimal 230), closer to 255 => FF
> Blue: E5 (Decimal 229), closer to 204 => CC
> ```
>
> **Example 3**
>
> ```text
> Input: $color = "#191A65"
> Output: "#003366"
>
> Red: 19 (Decimal 25), closer to 0 => 00
> Green: 1A (Decimal 26), closer to 51 => 33
> Blue: 65 (Decimal 101), closer to 102 => 66
> ```
>
> **Example 4**
>
> ```text
> Input: $color = "#2D5A1B"
> Output: "#336633"
>
> Red: 2D (Decimal 45), closer to 51 => 33
> Green: 5A (Decimal 90), closer to 102 => 66
> Blue: 1B (Decimal 27), closer to 51 => 33
> ```
>
> **Example 5**
>
> ```text
> Input: $color = "#00FF66"
> Output: "#00FF66"
>
> Red: 00 (Decimal 0), closer to 0 => 00
> Green: FF (Decimal 255), closer to 255 => FF
> Blue: 66 (Decimal 102), closer to 102 => 66
> ```

Actually there are three problems to solve:

- the conversion of a color string like `"#F4B2D1"` into a list of three numbers,
- the calculation of the nearest 'web-safe' value for each of these numbers,
- the conversion of the derived numbers back into the `"#FF99CC"` format.

#### Converting the color string into separate integers

For the first one, the conversion of an color string into numbers,
I was sure that a `pack` and `unpack` combination
would be very efficient.
And as I am always struggling a bit when it comes to using
`pack` and `unpack` I used the opportunity
to improve my knowledge in that respect.
So here is my solution using `pack` and `unpack`:

First, I use `unpack` to split the color string like `"#F4B2D1")`
into three separate strings of 2 characters each:

```perl
    unpack "x(a2)3", $color;    # ("F4", "B2", "D1")
```

Next, I use `pack` to transform these three values
as unsigned chars (0–255 each) into a 3-byte binary string: 

```perl
    pack "(H2)3", unpack "x(a2)3", $color;    # "\xf4\xb2\xd1"
```

This is only an intermediate step to read the bytes again
with `unpack`, extracting them as as unsigned integers:

```perl
    my @values = unpack "C3", pack "(H2)3", unpack "x(a2)3", $color;    # (244, 178, 209)
```

#### Calculating the nearest 'web-safe' intensities

The 'web-safe' values as integers are 0, 51, 102, 153, 204, 255.
The distance between them is constant: 51.
Actually it is good that this is an odd number,
because it makes this special type of rounding unambiguous:
there are exactly 20 values on each side of the target value
that are caught by the rounding.

At least this makes the rounding consistent.
We can apply a formula,
and we don't not need to consider any exceptions.

To do the rounding,
we increase the value to be transformed by half an interval
(the `20` that were mentioned before, actually `int( 51 /2 )`) .
Then we can round down to the nearest multiple of 51.
I do it this way:

```perl
    $_ =  int( ( $_ + int( 51 / 2 ) ) / 51 ) * 51
        for @values;
```

#### Return the RGB string

I could use `pack` and `unpack` again
for formatting the RGB color string that is to be returned,
but I prefer the traditional `sprintf` way,
because it is so much clearer:

```perl
    return sprintf "#%02X%02X%02X", @values;
```

#### Putting it together

 This is my complete solution:

```perl
use v5.36;

sub nearest_rgb( $color ) {
    my @values = unpack "C3", pack "(H2)*", unpack "x(a2)*", $color;
    $_ =  int( ( $_ + int( 51 / 2 ) ) / 51 ) * 51
        for @values;
    return sprintf "#%02X%02X%02X", @values;
}
```

**Thank you for the challenge!**

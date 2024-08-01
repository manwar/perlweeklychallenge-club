# More Weight for Examples!

**Challenge 279 solutions in Perl by Matthias Muth**

## Task 1: Sort Letters

> You are given two arrays, @letters and @weights.<br/>
> Write a script to sort the given array @letters based on the @weights.<br/>
> <br/>
> Example 1<br/>
> Input: @letters = ('R', 'E', 'P', 'L')<br/>
>        @weights = (3, 2, 1, 4)<br/>
> Output: PERL<br/>
> <br/>
> Example 2<br/>
> Input: @letters = ('A', 'U', 'R', 'K')<br/>
>        @weights = (2, 4, 1, 3)<br/>
> Output: RAKU<br/>
> <br/>
> Example 3<br/>
> Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')<br/>
>        @weights = (5, 4, 2, 6, 1, 3)<br/>
> Output: PYTHON<br/>

Probably the most efficient way to solve this task is *not* to use sort,
but to directly assign letters to their positions in the result string.
This works for all the examples,
because in these examples, the `@weights` are very regular:

- they can be mapped one-by-one to result positions,
- no weight appears twice,
- the weights cover all positions completely.

Actually, at least for the examples, `@weights` should be called `@positions`
(minding that they are one-based, not zero-based).

So here's the simple version, to cover the examples.<br/>
We need to initialize the result string to have the correct length,
because we will assign letters to positions in random order.

```perl
use v5.36;

sub sort_letters_1( $letters, $weights ) {
    my $result = " " x $letters->@*;
    substr $result, $weights->[$_] - 1, 1, $letters->[$_]
        for 0..$letters->$#*;
    return $result;
}
```



**What if the weights were not as regular as they are in the examples?**

We should consider cases where weights do *not* map one-by-one to positions.<br/>
Let's put some 'heavier weights' in, and consider this additional example:

> Example 4<br/>
> Input: @letters = ('R', 'E', 'P', 'L')<br/>
>             @weights = (3333, 2222, 1111, 3333)<br/>
> Output: PERL<br/>

 Here:

* the lowest weight is not 1,
* weights are not consecutive (they contain gaps),
* same weight values are used more than once for different letters<br/>(behavior is not defined in this case, but we should do something useful),

* the weight values are not necessarily small integers<br/>(which can cause memory problems when we incautiously map weight values to string positions or array indexes).

So what do we do?

My ideas are these:

* Use the weight values as hash keys instead of string positions or array indexes to store where any letter is going to be put.<br/>
  This addresses both the 'not consecutive' and the 'no small integers' issues.
  We can have a weight of 6548632 without running out of bounds as we would with a string or an array.
* Store a *list* of letters with each 'weight' hash key.<br/>This deals with the case of multiple letters having the same weight value.
  Every hash entry will contain an array-ref to a list of all letters having that weight.

I'm also happy to highlight the `for_list` Perl feature
that was added in Perl 5.36 for iterating over multiple values at a time.
Especially its use together with the `mesh` function from `List::Util`
makes some things simple and nice.<br/>
Where normally I would have to iterate over `0..$#array`,
I can avoid this here, as well as the use of `$_` in the loop.<br/>
Certainly less 'perlish', but easy for the eyes!

To get the result string from the hash, we sort the hash keys (numerically!)
and concatenate all letters from their entries in order.<br/>
Like this:

```perl
use v5.36;
no warnings 'experimental::for_list';
use List::Util qw( mesh );

sub sort_letters( $letters, $weights ) {
    my %buckets;
    for my ( $letter, $weight ) ( mesh $letters, $weights ) {
        push $buckets{$weight}->@*, $letter;
    }
    return join "", map $buckets{$_}->@*, sort { $a <=> $b } keys %buckets;
}
```



## Task 2: Split String

> You are given a string, \$str.<br/>
> Write a script to split the given string into two containing exactly same number of vowels and return true if you can otherwise false.<br/>
> <br/>
> Example 1<br/>
> Input: \$str = "perl"<br/>
> Ouput: false<br/>
> <br/>
> Example 2<br/>
> Input: \$str = "book"<br/>
> Ouput: true<br/>
> Two possible strings "bo" and "ok" containing exactly one vowel each.<br/>
> <br/>
> Example 3<br/>
> Input: \$str = "good morning"<br/>
> Ouput: true<br/>
> Two possible strings "good " and "morning" containing two vowels each or "good m" and "orning" containing two vowels each.<br/>

Actually the task assignment 'split the given string into two containing exactly same number of vowels' can be completely ignored. The result is never used. It's like a piece of 'dead code' that never gets executed and that can be removed.

The only information we need to return is whether *we can* split the string into two such pieces!

We can do so if and only if we can split up the string's *vowels* into two equal pieces.<br/>
Which means we need an even number of vowels.

Ok, then let's count the vowels!
And the rest is easy...

```perl
use v5.36;

sub split_string( $str ) {
    my @vowels = $str =~ /[aeiou]/ig;
    return scalar @vowels % 2 == 0;
}
```

#### **Thank you for the challenge!**

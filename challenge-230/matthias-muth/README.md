# One for the Regex, and Two for the Three
**Challenge 229 solutions in Perl by Matthias Muth**

## Task 1: Lexicographic Order

> You are given an array of strings.<br/>
> Write a script to delete element which is not lexicographically sorted (forwards or backwards) and return the count of deletions.<br/>
> Example 1<br/>
> Input: @str = ("abc", "bce", "cae")<br/>
> Output: 1<br/>
> In the given array "cae" is the only element which is not lexicographically sorted.<br/>
> <br/>
> Example 2<br/>
> Input: @str = ("yxz", "cba", "mon")<br/>
> Output: 2<br/>
> In the given array "yxz" and "mon" are not lexicographically sorted.<br/>

Once again, it's regex time!

This time, we create two patterns,
one that matches lexographically sorted input words,
and the other that does the same, but with the reversed alphabet.

The task description does not mention
whether the same letter appearing several times in a row still counts
as 'lexicographically' sorted, but let's assume it is.
That means that every letter of the alphabet can appear zero, one or more times.
So the two patterns should look like this:
```perl
    /^a*b*c*d*e*...x*y*z*$/
    /^z*y*x*...e*d*c*b*a*$/
```

The rest is easy, too.<br/>
We match each input word against both patterns in a `grep` call,
letting through those that do not match neither of the patterns.
`scalar` lets `grep`return the number of elements found,
which is our end result.

I love regular expressions!

```perl
use v5.36;

sub lexicographic_order( @str ) {
    my $a_to_z = join "", map( "$_*", "a".."z" );
    my $z_to_a = join "", map( "$_*", reverse "a".."z" );
    return scalar grep { ! /^$a_to_z$/i && ! /^$z_to_a$/i } @str;
}
```

## Task 2: Two out of Three

> You are given three array of integers.<br/>
> Write a script to return all the elements that are present in at least 2 out of 3 given arrays.<br/>
> <br/>
> Example 1<br/>
> Input: @array1 = (1, 1, 2, 4)<br/>
>        @array2 = (2, 4)<br/>
>        @array3 = (4)<br/>
> Ouput: (2, 4)<br/>
> <br/>
> Example 2<br/>
> Input: @array1 = (4, 1)<br/>
>        @array2 = (2, 4)<br/>
>        @array3 = (1, 2)<br/>
> Ouput: (1, 2, 4)<br/>

An exercise in counting.<br/>
But we must be careful not to just count all elements of the three arrays,
since we would get a wrong result if a number is contained several times,
but in only one of the arrays.

So let's first run the arrays through `uniq`, to avoid duplicates,
then we start counting, using a hash as usual.
As we have to do the `uniq` three times, once for each array,
we may as well generalize that and use `map` to map any number of arrays
to their `uniq`ed numbers.
We still can do all of this in the same statement.

Then we `grep` those elements that appear at least twice,
and we sort the result -- because it looks better and we are friendly,
but also because we want to match the expected output.     

```perl
use v5.36;

use List::Util qw( uniq );

sub two_out_of_three ( $array1, $array2, $array3 ) {
    my %frequencies;
    $frequencies{$_}++
        for map uniq( @$_ ), $array1, $array2, $array3;
    return sort { $a <=> $b } grep { $frequencies{$_} >= 2 } keys %frequencies;
}
```

#### **Thank you for the challenge!**

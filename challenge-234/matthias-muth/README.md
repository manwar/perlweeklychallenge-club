# More Frequent Frequencies

**Challenge 234 solutions in Perl by Matthias Muth**

## Task 1: Common Characters

> You are given an array of words made up of alphabetic characters only.<br/>
> Write a script to return all alphabetic characters that show up in all words including duplicates.<br/>
> <br/>
> Example 1<br/>
> Input: @words = ("java", "javascript", "julia")<br/>
> Output: ("j", "a")<br/>
> <br/>
> Example 2<br/>
> Input: @words = ("bella", "label", "roller")<br/>
> Output: ("e", "l", "l")<br/>
> <br/>
> Example 3<br/>
> Input: @words = ("cool", "lock", "cook")<br/>
> Output: ("c", "o")<br/>

In earlier challenges, I used regular expressions for checking whether a given word can be built from the letters of a given alphabet ([221 Task 1 'Good Strings'](https://github.com/MatthiasMuth/perlweeklychallenge-club/tree/muthm-221/challenge-221/matthias-muth#readme), [224 Task 1 'Special Notes'](https://github.com/MatthiasMuth/perlweeklychallenge-club/tree/muthm-224/challenge-224/matthias-muth#readme), [229 Task 1 'Lexicographic Order'](https://github.com/MatthiasMuth/perlweeklychallenge-club/tree/muthm-229/challenge-229/matthias-muth#readme)).<br/>
For example, to decide whether the word 'cat'
could be built from an alphabet containing the letters of the word 'atach',
I sorted the letters of both,
and built a regular expression based on the word:

```perl
    'cat'   sorted:  a-c-t
    'catch' sorted:  a-a-c-h-t
    "aacht" =~ /^ .* a .* c .* t .* $/x
```

My first thought was that I could use the same trick for this task.
But here, we don't just need to decide whether a word matches, but we need to filter out all letters that are *not* contained in the word, like through a sieve. I was not sure whether this would not be too complicated for a nice solution for this task, so I first implemented a more 'traditional' approach, to have something working. I would maybe come back later to work on a solution based on regular expressions. See below! ;-)

#### Using frequency counts and `grep`

For this first solution, I first produce a count of available characters in each word.<br/>
For example, `"java"` translates to
`{ a => 2, j => 1, v => 1 }`.

```perl
    my @available_chars;
    for my $i ( 0..$#words ) {
        ++$available_chars[$i]{$_}
            for split //, $words[$i];
    }
```

Next, we check which characters are contained in *all* words.<br/>
No character can be in *all* words if it is not contained in the *first* word,
so I use the first word for an initial list of characters.<br/>
I pass this list through `grep`,
with a code block that let's those characters pass through
that are available in all words
(skipping the first, that would be redundant).
Using `all` from `List::Util` for this.

The test decreases each availability count at the same time,
so that each character can only be used as often as it exists in each word.
To make it simple, I don't care about decreasing into negative numbers
-- it only matters that the character is not available.

The letters that make it through the `grep` can then directly be returned as the result.<br/>
So this is the complete solution:

```perl
use List::Util qw( all );

sub common_characters_1( @words ) {
    my @available_chars;
    for my $i ( 0..$#words ) {
        ++$available_chars[$i]{$_}
            for split //, $words[$i];
    }

    return
        grep {
            my $char = $_;
            all { ( $available_chars[$_]{$char}-- // 0 ) > 0 } 1..$#words
        } split //, $words[0];
}
```

#### Using regular expressions to filter out characters

Now that I had a working solution, I also tried to find a solution that is based on regular expressions.

What we need is a regex that, when a word is matched against it, *returns* those letters that are allowed, and silently ignores all letters that are not allowed. How do we do that?

Let's start with *how* the allowed letters are returned, and let's use Example 1 ("java", "javascript", "julia") as an example. After sorting the letters in each word, we have these words:

```perl
java        => aajv
javascript  => aacijprstv
julia       => aijlu
```

As in the solution above, we use the first word as the initial set of valid letters.<br/>
We want to return the matching letters in capture groups.<br/>


So for matching "javascript" against "java", after sorting the letters we have to match the following, allowing for other characters between the ones that we are looking for:

```perl
"aacijprstv" =~ /^ (a) (a) .*? (j) .*? (v)/x
```

The first `.*?` will catch "ci", the second one "prst".<br/>
But we also need to allow for letters *not* being present, so

```perl
"aacijprstv" =~ /^ (a?) (a?) .*? (j?) .*? (v?)/x
```

But this doesn't work.<br/>The first `.*?` pattern now catches everything up to the end,
because everything following it is now optional.<br/>
So we need to limit the `.*?` to in no case match the expected next character,
be it there or not.<br/>
We can do that by replacing for example `.*? (j?)` by `[a-i]* (j?)`.<br/>
This will work, but there is no really elegant way of producing `[a-i]`
when we only know the letter `j` that we want to match
(sure, there's `chr( ord( $_ ) - 1 )` to prodce the 'i', but is this elegant?).

There's another trick that we can apply:
We write `[a-j]` (we know the `j`!),
but we make sure that a `j` will never be matched at this point,
using a 'negative lookahead'.
Like this: `(?: (?!j)[a-j] )*`.<br/>
So what we are actually saying is
'if the next character is not a "j", give us that character if it is from "a" to "j"'.<br/>
Ok, maybe I have to rethink my definition of 'elegance'.

Anyway, my example now looks like this:
```perl
"aacijprstv" =~ /^ (a?) (a?) (?:(?!j)[a-j])* (j?) (?:(?!v)[a-v])* (v?)/x
```
The captures like '(a?)' will return an empty string
if there is no 'a' at that point.
We need to filter those empty captures away.

Now we still need to generate this regex,
but now as we know what we need, this is quite straightforward.<br/>
Here  is the whole solution:
```perl
sub common_characters( @words ) {
    my @sorted_words = map join( "", sort split //, $_ ), @words;
    my @result_chars = split //, $sorted_words[0];
    for ( @sorted_words[1..$#sorted_words] ) {
        my $re = join " ", map "(?:(?!$_)[a-$_])* ($_?)", @result_chars;
        @result_chars = grep $_ ne "", /^$re/x;
    }
    return @result_chars;
}
```

Maybe a bit extravagant, but it was quite interesting to develop it!

There is one problem left with this solution:<br/>
The order of letters returned does not always correspond with the results given in the examples.
If we want to get the result characters in the order they appear in the first word
(as the examples suggest)
we first need to
do a frequency count of the result characters,
and then go through the first word, filtering letters for availability,
decreasing the availability on the fly,  just like in the other solution above:
```perl
    my %freq;
    ++$freq{$_}
        for @result_chars;
    return grep { $freq{$_}-- // 0 > 0 } split //, $words[0];
```
With this, all output will be exactly as in the examples.

## Task 2: Unequal Triplets

> You are given an array of positive integers.<br/>
> Write a script to find the number of triplets (i, j, k) that satisfies num[i] != num[j], num[j] != num[k] and num[k] != num[i].<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (4, 4, 2, 4, 3)<br/>
> Ouput: 3<br/>
> (0, 2, 4) because 4 != 2 != 3<br/>
> (1, 2, 4) because 4 != 2 != 3<br/>
> (2, 3, 4) because 2 != 4 != 3<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (1, 1, 1, 1, 1)<br/>
> Ouput: 0<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (4, 7, 1, 10, 7, 4, 1, 1)<br/>
> Output: 28<br/>
> triplets of 1, 4, 7  = 3x2×2 = 12 combinations<br/>
> triplets of 1, 4, 10 = 3×2×1 = 6  combinations<br/>
> triplets of 4, 7, 10 = 2×2×1 = 4  combinations<br/>
> triplets of 1, 7, 10 = 3x2x1 = 6 combinations<br/>

A brute force solution for counting the would be to loop over $i$, $j$ and $k$,
counting each triplet that fulfills the criteria.
This takes $i (i-1) (i-2)$ iterations.

Actually this is no problem for the examples (max. $8\cdot7\cdot6 = 336$ iterations).

But we can implement a more efficient solution easily by not looping over all numbers, but only over the groups of unique numbers, as Example 3 suggests.
For that example, with its four unique numbers (1, 4, 7, 10),
this means only '4 choose 3', or $\binom{4}{3} = \frac{4!}{3!(4-3)!} = 4$ combinations,
as they are explained in in the example.

So after counting the frequency of the numbers
we have a similar loop nested loop,
but we do not add one for each triplet,
but the product of the frequencies of the number groups.

So here we go:   

```perl
use List::Util qw( product );

sub unequal_triplets( @ints ) {
    # Count the numbers.
    my %frequencies;
    ++$frequencies{$_}
        for @ints;

    # Check whether there are any triplets at all.
    return 0
        unless %frequencies >= 3;

    # Go through combinations of unique numbers.
    my $n_combinations = 0;
    my @uniq_ints = sort { $a <=> $b } keys %frequencies;
    for my $i1 ( 0..$#uniq_ints ) {
        for my $i2 ( ( $i1 + 1 ) .. $#uniq_ints ) {
            for my $i3 ( ( $i2 + 1 ) .. $#uniq_ints ) {
                $n_combinations +=
                    product( @frequencies{ @uniq_ints[ $i1, $i2, $i3 ] } );
            }
        }
    }
    return $n_combinations;
}
```

#### **Thank you for the challenge!**

# Too lazy for programming it? Let *regex* do the work!
**Challenge 221 solutions in Perl by Matthias Muth**

## Task 1: Good Strings

> You are given a list of @words and a string $chars.<br/>
> <br/>
> A string is good if it can be formed by characters from $chars, each character can be used only once.<br/>
> <br/>
> Write a script to return the sum of lengths of all good strings in words.<br/>
> <br/>
> Example 1<br/>
> Input: @words = ("cat", "bt", "hat", "tree")<br/>
>        $chars = "atach"<br/>
> Output: 6<br/>
> The good strings that can be formed are "cat" and "hat" so the answer is 3 + 3 = 6.<br/>
> <br/>
> Example 2<br/>
> Input: @words = ("hello", "world", "challenge")<br/>
>        $chars = "welldonehopper"<br/>
> Output: 10<br/>
> The strings that can be formed are "hello" and "world" so the answer is 5 + 5 = 10.<br/>

We could go through the letters of each word,
and surgically operate out each single one from the list of characters that we
have left for this word.
Once we don't find a letter, we know that we don't have a 'good string'.<br/>
This involves a lot of searching,
and doesn't look like a very efficient solution to me.<br/>
And much too much work!!

But we can use another approach.<br/>
We are talking about words and lists of characters
and one being contained in the other,
which makes '*regular expressions*' start blinking in my head...<br/>

Now it's not as simple as comparing each word letter
against the list of characters,
because we can use each character only once.
We kind of need to keep track of this.

But if we sorted the letters of the word first, and also the list characters,
and compare then, in one pattern?<br/>
Let's have a look at the word 'cat' and the letters 'atach'
from the first example:

    'cat'   sorted:  a-c-t
    'atach' sorted:  a-a-c-h-t

We, as humans, see the characters that match,
and some other characters in between
that don't match (but also don't need to match!).<br/>
How can we turn this into a regular expression?

Actually we need to turn things around!<br/>
Instead of matching the word against the characters, we match the characters
against the word letters as a pattern.
And as there may be characters in the character list
that *don't* appear in the word,
we allow for some skipping over them.  
Something like this:

    "aacht" =~ /^ .* a .* c .* t .* $/x

If the sorted sequence of characters matches the regular expression
that we derived from the word this way, that word is 'good'.

So what we need to do is to construct the character string
from the sorted list of characters (once),
and the pattern for each word (in a loop over the words).<br/>
And if we have a match, we add the length of the word to the result:

```perl
sub good_strings {
    my ( $words, $chars ) = @_;

    my $ordered_chars = join "", sort split '', $chars;
    my $result = 0;
    for my $word ( @$words ) {
        my $pattern = '^.*' . join( '.*', sort split '', $word ) . '.*$';
        $result += length( $word )
            if $ordered_chars =~ /${pattern}/;
    }
    return $result;
}
```
With some added output, the function produces this:
```
ordered chars: aacht
pattern for 'cat': qr/^.*a.*c.*t.*$/
pattern for 'bt': qr/^.*b.*t.*$/
pattern for 'hat': qr/^.*a.*h.*t.*$/
pattern for 'tree': qr/^.*e.*e.*r.*t.*$/
ok 1 - Example 1: good_strings( (["cat", "bt", "hat", "tree"], "atach") ) == 6

ordered chars: deeehllnoopprw
pattern for 'hello': qr/^.*e.*h.*l.*l.*o.*$/
pattern for 'world': qr/^.*d.*l.*o.*r.*w.*$/
pattern for 'challenge': qr/^.*a.*c.*e.*e.*g.*h.*l.*l.*n.*$/
ok 2 - Example 2: good_strings( (["hello", "world", "challenge"], "welldonehopper") ) == 10
```

Sometimes I really like being lazy! :-D<br/>
And I am always amazed about what *regexes* can do!

## Task 2: Arithmetic Subsequence

> You are given an array of integers, @ints.<br/>
> Write a script to find the length of the longest Arithmetic Subsequence in the given array.<br/>
> <br/>
> A subsequence is an array that can be derived from another array by deleting some or none elements without changing the order of the remaining elements.<br/>
> A subsquence is arithmetic if ints[i + 1] - ints[i] are all the same value (for 0 <= i < ints.length - 1).<br/>

'Oh, another permutation task!' is what I thought first.<br/>
Actually yes, but also actually no.

Yes, in that we need to do some permutations.<br/>
But no, in that we only need to go through the permutations
of the first two numbers in a subsequence.<br/>
And this we can easily do in a nested loop.

No recursion needed. No breadth-first or depth-first traversal needed.
Just a nested loop.

In the outer loop we choose the first element of the subsequence
that we are going to check,
and in the next inner loop we choose its second element,
from the rest of the list.<br/>
And in the body, using a third loop we look for more elements
in the rest of the list
that continue the arithmetic subsequence started by the first two.

If we find an element that has the same difference to the previous one,
it belongs to that Arithmetic Subsequence, as the definition states.<br/>
For any subsequence we try,
we count its length while walking through the elements,
and remember the length of the longest subsequence found.

Actually, for solving the task, we don't need to extract any subsequences
(as the description might suggest).
It's enough to find the elements of the subsequences,
and to know their lengths to find the maximum.

```perl
sub arithmetic_subsequence {
    my @ints = @_;

    my $max = 0;
    # Choose a starting number.
    for my $i ( 0..$#ints ) {
        # Choose a second number from the rest of the list.
        for my $j ( $i + 1 .. $#ints ) {
            # The two numbers already form an arithmetic subsequence
            # of length 2.
            my $count = 2;
            # Go through the rest of the list looking for more numbers with
            # the same difference between them.
            my $diff = $ints[$j] - $ints[$i];
            my $next_expected = $ints[$j] + $diff;
            for my $k ( $j + 1 .. $#ints ) {
                if ( $ints[$k] == $next_expected ) {
                    $count++;
                    $next_expected += $diff;
                }
            }
            $max = $count
                if $count > $max;
        }
    }
    return $max;
}
```

#### **Thank you for the challenge!**

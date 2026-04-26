# Scrambling Back and Forth

**Challenge 370 solutions in Perl by Matthias Muth**

## Task 1: Popular Word

> You are given a string paragraph and an array of the banned words.<br/>
> Write a script to return the most popular word that is not banned. It is guaranteed there is at least one word that is not banned and the answer is unique. The words in paragraph are case-insensitive and the answer should be in lowercase. The words can not contain punctuation symbols.
>
> **Example 1**
>
> ```text
> Input: $paragraph = "Bob hit a ball, the hit BALL flew far after it was hit."
>        @banned = ("hit")
> Output: "ball"
>
> After removing punctuation and converting to lowercase, the word "hit" appears 3 times, and "ball" appears 2 times.
> Since "hit" is on the banned list, we ignore it.
> ```
>
> **Example 2**
>
> ```text
> Input: $paragraph = "Apple? apple! Apple, pear, orange, pear, apple, orange."
>        @banned = ("apple", "pear")
> Output: "orange"
>
> "apple"  appears 4 times.
> "pear"   appears 2 times.
> "orange" appears 2 times.
>
> "apple" and "pear" are both banned.
> Even though "orange" has the same frequency as "pear", it is the only non-banned word with the highest frequency.
> ```
>
> **Example 3**
>
> ```text
> Input: $paragraph = "A. a, a! A. B. b. b."
>        @banned = ("b")
> Output: "a"
>
> "a" appears 4 times.
> "b" appears 3 times.
>
> The input has mixed casing and heavy punctuation.
> The normalised, "a" is the clear winner, since "b" is banned, "a" is the only choice.
> ```
>
> **Example 4**
>
> ```text
> Input: $paragraph = "Ball.ball,ball:apple!apple.banana"
>        @banned = ("ball")
> Output: "apple"
>
> Here the punctuation acts as a delimiter.
> "ball"   appears 3 times.
> "apple"  appears 2 times.
> "banana" appears 1 time.
> ```
>
> **Example 5**
>
> ```text
> Input: $paragraph = "The dog chased the cat, but the dog was faster than the cat."
>        @banned = ("the", "dog")
> Output: "cat"
>
> "the" appears 4 times.
> "dog" appears 2 times.
> "cat" appears 2 times.
>
> "chased", "but", "was", "faster", "than" appear 1 time each.
> "the" is the most frequent but is banned.
> "dog" is the next most frequent but is also banned.
> The next most frequent non-banned word is "cat".
> ```

I was looking for an effective way of walking through the words only once,
counting the number of occurrences of each word
and remembering the highest number at the same time.

I found that `max_by` from `List::UtilsBy` can do exactly that.
With the help of a 'frequency hash',
incremented for the current word within each iteration,
it selects the highest value and then returns the corresponding word
in just one elegant call:

```perl
    my %n_occurences;
    return max_by { ++$n_occurences{$_} } @words;
```

As the rest of my solution has several steps,
I have put in comments into it as I would for a production program.
So I let the code and comments stand for themselves:

```perl
use v5.36;
use List::UtilsBy qw( max_by );

sub popular_word( $paragraph, $banned ) {
    # Create a lookup for banned words.
    my %is_banned = map { $_ => 1 } $banned->@*;

    # Replace everything non-alpha and non-whitespace by whitespace.
    $paragraph =~ s/[^[:alpha:]\s]+/ /g;

    # Split up in words, filtering out banned words.
    my @words = grep ! $is_banned{$_}, split " ", lc $paragraph;

    # Find the word with the highest number of occurrences,
    # counting as we walk through all the words.
    my %n_occurences;
    return max_by { ++$n_occurences{$_} } @words;
}
```

## Task 2: Scramble String

> You are given two strings A and B of the same length.<br/>
> Write a script to return true if string B is a scramble of string A otherwise return false.<br/>
> String B is a scramble of string A if A can be transformed into B by a single (recursive) scramble operation.<br/>
> A scramble operation is:<br/>
>
> - If the string consists of only one character, return the string.<br/>
> - Divide the string X into two non-empty parts.<br/>
> - Optionally, exchange the order of those parts.<br/>
> - Optionally, scramble each of those parts.<br/>
> - Concatenate the scrambled parts to return a single string.
>
> **Example 1**
>
> ```text
> Input: $str1 = "abc", $str2 = "acb"
> Output: true
> 
> "abc"
> split: ["a", "bc"]
> split: ["a", ["b", "c"]]
> swap: ["a", ["c", "b"]]
> concatenate: "acb"
> ```
>
> **Example 2**
>
> ```text
> Input: $str1 = "abcd", $str2 = "cdba"
> Output: true
> 
> "abcd"
> split: ["ab", "cd"]
> swap: ["cd", "ab"]
> split: ["cd", ["a", "b"]]
> swap: ["cd", ["b", "a"]]
> concatenate: "cdba"
> ```
>
> **Example 3**
>
> ```text
> Input: $str1 = "hello", $str2 = "hiiii"
> Output: false
> 
> A fundamental rule of scrambled strings is that they must be anagrams.
> ```
>
> **Example 4**
>
> ```text
> Input: $str1 = "ateer", $str2 = "eater"
> Output: true
> 
> "ateer"
> split: ["ate", "er"]
> split: [["at", "e"], "er"]
> swap: [["e", "at"], "er"]
> concatenate: "eater"
> ```
>
> **Example 5**
>
> ```text
> Input: $str1 = "abcd", $str2 = "bdac"
> Output: false
> ```

There are two approaches to solve this task:

* Create all possible scrambles of `$str1`, and check whether `$str2` is one of them.
* Directly check whether `$str2` is a 'scramble' of `$str1`,
  by trying to reverse the operations that led to `$str2`.

Even if for the examples given it may be less of a problem,
the first method ('brute force') can easily exceed acceptable runtime limits.
The number of permutations grows fast with the number of letters in `$str1`.

At the same time, finding a 'reverse scramble' might be faster,
but could also be a quite non-trivial task to implement.

This is what I developed:

#### The idea of 'reverse scrambling':

The objective is to find a direct check,
without generating all possible scrambles first.

If `$str2` is a scramble of `$str1`,
there must be a sequence of flipping operations and recombinations
that lead back to the original sequence in `$str1`.
This is like a kind of 'sort' operation to recreate the original order.

It os much easier to sorting a sequence of numbers into a given order
than sorting random letters into their original positions.
So my first step is to replace the letters in `$str1` by their index,
and then replace the letters in `$str2`
by the index of the same letter in `$str1`.

Here is an example to illustrate the idea:

```text
$str1 = "abcdef", $str2 = "cdfeba"
$str1 in numbers: ( 0, 1, 2, 3, 4, 5 )
$str2 in numbers: ( 2, 3, 5, 4, 1, 0 )
```

Next, I combine adjacent numbers to form 'streaks' of contiguous numbers.
Every streak is then sorted.
This is done repetitively,
combining adjacent streaks if they can form a contiguous new streak.

Starting with streaks containing each single number
of the original `$str2` sequence:

```text   
Starting sequence:
    ( 2 ) ( 3 ) ( 5 ) ( 4 ) ( 1 ) ( 0 )
Combining ( 2 ) and ( 3 ):
    ( 2, 3 ) ( 5 ) ( 4 ) ( 1 ) ( 0 )
( 5 ) cannot be combined with ( 2, 3 ),
so we work with ( 5 ) as a new streak.
Combining ( 5 ) and ( 4 ), then sorting the new streak:
    ( 2, 3 ) ( 4, 5 ) ( 1 ) ( 0 )
( 1 ) cannot be combined with ( 4, 5 ),
so we work with ( 1 ) as a new streak:
Combining ( 1 ) and ( 0 ), then sorting the new streak:
    ( 2, 3 ) ( 4, 5 ) ( 0, 1 )

Reaching the end, starting a new pass:
Combining ( 2, 3 ) and ( 4, 5 ), then sorting the new streak:
    ( 2, 3, 4, 5 ) ( 0, 1 )
Combining ( 2, 3, 4, 5 ) and ( 0, 1 ), then sorting the new streak:
    ( 0, 1, 2, 3, 4, 5 )
```

In the end only one single streak is left, so we know that we have just found a correct reverse scramble!

Let's try Example 5 as an example for a *non*-correct scramble. We should not be able to find a correct reverse scramble:

```text
$str1 = "abcd", $str2 = "bdac"
Starting sequence:
    ( 1 ) ( 3 ) ( 0 ) ( 2 )
```

Actually there is not a single possibility to combine two adjacent single-number streaks into a contiguous sequence, which means that there is no way that this sequence was produced by a correct scramble.

#### Limitations

The approach shown works well as long as `$str1` does not contain duplicate letters.
If it does, we might or might not be able to find a reverse scramble,
because the numbers representing the duplicate letters
might or might not be in a place where we can reorder them correctly.
In any case, if there are duplicate letters,
they need to have the number representations of their specific positions
in the original string, not all the same number.
Probably we would then need to permute
the numbers representing the duplicates
and try to find reverse scrambles for all of the permutations. 

For Example 4, that looks like this:

```text
$str1 = "ateer", $str2 = "eater"
$str1 in numbers: ( 0, 1, 2, 3, 4 )
Duplicate "e" at positions 2 and 3.
$str2 in numbers: ( 2, 0, 1, 3, 4 )
            *or*: ( 3, 0, 1, 2, 4 )
```

This can become a bit complicated if there are several different letters appearing more than once.

Actually it turns out that for Example 4, both permuted sequences can correctly be reverse-scrambled, so  for the time being I did not  implement that permutation.

#### Preparing tests for the reverse scrambling method

For a complete test of the reverse scrambling method
for a string `$str1` of a given length,
I need to compare all possible permutations of the letters in `$str1`
against a the list of all possible scrambles of `$str1`.

This means that for testing the 'fast' method of reverse scrambling,
we are back to creating the 'brute force' method first
that creates all permutations,
just for getting correct expectations for the tests.

Actually this is what happens sometimes in test driven development:
you do a complete second implementation
to create the tests for what you actually plan to implement,
*before* you implement what is your main target.

So I start with implementing a `scrambles` subroutine
that returns all possible scrambles of a string, just for creating test data for the future implementation:

```perl
use v5.36;

sub scrambles( $str ) {
    return $str
        if length( $str ) == 1;
    my %results;
    for ( 1 .. length( $str ) - 1 ) {
        my @part1_scrambles = scrambles( substr( $str, 0, $_ ) );
        my @part2_scrambles = scrambles( substr( $str, $_ ) );
        for my $a ( @part1_scrambles ) {
            for my $b ( @part2_scrambles ) {
                ++$results{"$a$b"};
                ++$results{"$b$a"};
            }
        }
    }
    return keys %results;
}
```

#### Shortcut to Version 1.0

Obviously, this already  implements the main part of the 'brute force' solution.
I just added a short subroutine to run the challenge task examples,
and I call this my 'Solution Version 1.0'.

```perl
# Challenge task solution v1.0 (brute force):
use List::Util qw( any );
sub is_scramble( $str1, $str2 ) {
    return any { $_ eq $str2 } scrambles( $str1 );
}
```

#### Version 2.0, the 'Reverse Scramble' 

This is the implementation in Perl of the 'Reverse Scramble' checking algorithm:
```perl
# Challenge task solution v2.0 ('Reverse Scramble'):
sub is_reverse_scramble( $str1, $str2 ) {

    # Convert the strings into sequences of index numbers,
    # taking care of assigning different numbers to duplicate
    # characters.
    my %indexes;
    for my ( $index, $letter ) ( indexed split "", $str1 ) {
        push $indexes{$letter}->@*, $index;
    }

    # Create single number streaks.
    my @streaks =
        map [ shift $indexes{$_}->@* // return false ],
            split "", $str2;

    # Repetitively combine adjacent streaks if they form a contiguous
    # new streak.
    while ( @streaks > 1 ) {
        # Use a separate array for building the combined streaks,
        # because manipulating the @streaks array within the loop
        # is too dangerous.
        my @new_streaks = ( $streaks[0] );
        my $could_combine = false;
        for ( @streaks[ 1 .. $#streaks ] ) {
            if ( $_->[0] == $new_streaks[-1][-1] + 1 ) {
                # Combine in current order.
                $could_combine = true;
                push $new_streaks[-1]->@*, $_->@*;
            }
            elsif ( $new_streaks[-1][0] == $_->[-1] + 1 )
            {
                # Combine in exchanged order.
                $could_combine = true;
                unshift $new_streaks[-1]->@*, $_->@*;
            }
            else {
                # No combination.
                push @new_streaks, $_;
            }
        }
        # No combinations were possible. Return failure.
        return false
            if ! $could_combine;

        # Prepare the next iteration.
        @streaks = @new_streaks;
    }
    return true;
}
```

#### **Thank you for the challenge!**

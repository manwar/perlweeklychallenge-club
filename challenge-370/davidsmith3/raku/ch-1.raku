#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Challenge 370 Task 1 
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given a string paragraph and an array of the banned words.

Write a script to return the most popular word that is not banned. It is guaranteed there is at least one word that is not banned and the answer is unique. The words in paragraph are case-insensitive and the answer should be in lowercase. The words can not contain punctuation symbols.

=head3 Example 1:
Input: $paragraph = "Bob hit a ball, the hit BALL flew far after it was hit."
       @banned = ("hit")
Output: "ball"

After removing punctuation and converting to lowercase, the word "hit" appears 3 times, and "ball" appears 2 times.
Since "hit" is on the banned list, we ignore it.

=head3 Example 2:
Input: $paragraph = "Apple? apple! Apple, pear, orange, pear, apple, orange."
       @banned = ("apple", "pear")
Output: "orange"

"apple"  appears 4 times.
"pear"   appears 2 times.
"orange" appears 2 times.

"apple" and "pear" are both banned.
Even though "orange" has the same frequency as "pear", it is the only non-banned word with the highest frequency.

=head3 Example 3:
Input: $paragraph = "A. a, a! A. B. b. b."
       @banned = ("b")
Output: "a"

"a" appears 4 times.
"b" appears 3 times.

The input has mixed casing and heavy punctuation.
The normalised, "a" is the clear winner, since "b" is banned, "a" is the only choice.

=head3 Example 4:
Input: $paragraph = "Ball.ball,ball:apple!apple.banana"
       @banned = ("ball")
Output: "apple"

Here the punctuation acts as a delimiter.
"ball"   appears 3 times.
"apple"  appears 2 times.
"banana" appears 1 time.

=head3 Example 5:
Input: $paragraph = "The dog chased the cat, but the dog was faster than the cat."
       @banned = ("the", "dog")
Output: "cat"

"the" appears 4 times.
"dog" appears 2 times.
"cat" appears 2 times.

"chased", "but", "was", "faster", "than" appear 1 time each.
"the" is the most frequent but is banned.
"dog" is the next most frequent but is also banned.
The next most frequent non-banned word is "cat".

=end pod

sub my-sub(Str:D $paragraph, Str @banned --> Str) {
    $paragraph
        .lc                                        # paragraph is case-insensitive and answer should be lower
        .split(/ <+punct +space>+ /, :skip-empty)  # split on word boundaries, example 4 says punct is a boundary
        .grep({ $_ !(elem) @banned })              # remove banned
        .Bag                                       # add word to counter
        .max({ $_.value })                         # guaranteed there is at least one word
        .key;
}

#| get most popular word after removing comma delimited banned words
multi MAIN(Str:D $paragraph, Str:D $banned) {
    my Str @banned-words = $banned.split(",").map({ .trim });
    say my-sub($paragraph, @banned-words);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    plan +@tests;
    for @tests {
        is my-sub(|.<input>), .<output>, "{.<input>}";
    }
}

sub extract-tests(--> Array[Hash]) {
    my Hash @tests;
    my $string = / '"' <-["]>* '"' /;
    my $list = / '(' <-[(]>* ')' /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($list) .* ($string)  / {
                my Str @banned = $1.EVAL.Array;
                @tests.push(%{ input => ($0.EVAL, @banned), output => $2.EVAL });
            }
        }
    }
    @tests;
}

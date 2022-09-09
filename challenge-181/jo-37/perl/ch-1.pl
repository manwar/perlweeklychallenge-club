#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [FILE]

-examples
    run the examples from the challenge
 
-tests
    run some tests

FILE
    name of a file containing the input text,
    use '-' for STDIN.

EOS


### Input and Output

print order_sentences(do {local $/; <>});


### Implementation

# "Write a script to order each sentence alphanumerically and print the
# whole paragraph."  Certainly we just entered the realm of uncertainty.
# Making some observations (O) and assumptions (A):
# - (A) Take the whole given text as one "paragraph".
# - (O) Split the paragraph into "sentences" that are parts terminated
#   with a dot, optionally followed by whitespace.
# - (O) Sentences are made up by "words" separated by whitespace.
# - (A) An "ordered sentence" consists of the sentence's sorted
#   words.
# - (A) An "alphanumerical" string is a string consisting of
#   letters and digits only.
# - (A) An "alphanumeric order" is the order induced by reducing
#   the given strings to their alphanumeric characters.
# - (O) Sorting is case-insensitive, but:
# - (O) An uppercase letter comes before the same lowercase letter.
# - (O) Non-alphanumeric characters are preserved.


# Unwinding backwards:
# - split the paragraph into sentences
# - split a sentence into words
# - Schwartzian transform: Build pairs of the alphanumeric reduction of
#   a word and the word itself
# - Sort the words by their alphanumeric reduction - case insensitive
#   first, then upper before lower case
# - drop the alphanumeric reduction
# - join words
# - join sentences, append dot and newline
sub order_sentences {
    join('. ', 
        map {
            join ' ',
            map {$_->[1]}
            sort {lc $a->[0] cmp lc $b->[0] || $a->[0] cmp $b->[0]}
            map {[tr/a-zA-Z0-9//cdr, $_]}
            split /\s+/, $_
        } split /\.\s*/, shift
    ) . ".\n";
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

    is order_sentences(<<IN), <<EXP =~ s/\n(?!$)/ /gr, 'example';
All he could think about was how it would all end. There was
still a bit of uncertainty in the equation, but the basics
were there for anyone to see. No matter how much he tried to
see the positive, it wasn't anywhere to be seen. The end was
coming and it wasn't going to be pretty.
IN
about All all could end he how it think was would. a anyone
basics bit but equation, for in of see still the the There
there to uncertainty was were. anywhere be he how it matter
much No positive, see seen the to to tried wasn't. and be
coming end going it pretty The to was wasn't.
EXP
    }

    SKIP: {
        skip "tests" unless $tests;

        is order_sentences("tool's tool-bar tool-tips."),
        "tool-bar tool's tool-tips.\n",
        'ignore non-alphanumeric characters';

        is order_sentences("tools tOOLS Tools"),
        "Tools tOOLS tools.\n",
        'order by case';

        is order_sentences("a09t b34x a12y b12z"),
        "a09t a12y b12z b34x.\n",
        'alphanumeric';
	}

    done_testing;
    exit;
}

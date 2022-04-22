#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Lingua::EN::Nums2Words;
use experimental 'signatures';

our ($tests, $examples);

Lingua::EN::Nums2Words::set_case('lower');

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    Explain N.

EOS


### Input and Output

say four_is_magic(shift);


### Implementation

# I avoided any web research on the topic and came to this conclusion:
# Here a "magic number" is a number that equals the length of its English
# cardinal representation.  Obviously, four is magic and it's the only
# magic number below ten.  One can assume that the English cardinal
# representation's length is bound by C * log10(N) and thus there cannot
# be any large magic number.  Given that there is no other magic number
# below 1000, four is the only magic number and the sequence obtained by
# repeated application of the representational length operation must
# always lead to four.
#
# The task states: "You are given a positive number, $n < 10".  I do not
# see any reason to exclude zero and from the considerations above there
# is no need to restrict N to be less than ten.  Thus generalizing the
# task to any non-negative integer.

sub four_is_magic ($n) {
    # Sanity check.
    die "not an integer" unless $n =~ /^\d+$/;
    # Substitute a non-magic number at the end of the string with its
    # "explanation" followed by its representational length until the
    # magic number four is reached.
    1 while $n =~ s{
        ^\D*\K  # Keep the string's starting text.
        (?!4$)  # Stop at the magic four.
        (\d+)$  # Capture a number at the end of the string.
    }
    {
        my $word = num2word $1;
        my $len = length $word;
        "$word is @{[num2word $len]}, $len" # generate an explanation
    }ex;

    # Explain the magic number and titlecase the result.
    $n =~ s/^(\D*)(\d+)$/"\u$1@{[num2word $2]} is magic."/er
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is four_is_magic(5),
        'Five is four, four is magic.', 'example 1';

        is four_is_magic(7),
        'Seven is five, five is four, four is magic.', 'example 2';

        is four_is_magic(6),
        'Six is three, three is five, five is four, four is magic.',
        'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is four_is_magic(4), 'Four is magic.', 'Four is magic.';
        is four_is_magic(100),
        'One hundred is eleven, eleven is six, six is three, three is five, five is four, four is magic.',
        'one hundred';

        is four_is_magic(88666),
        'Eighty-eight thousand, six hundred sixty-six is forty-four, forty-four is ten, ten is three, three is five, five is four, four is magic.',
        'contains 44';
	}

    done_testing;
    exit;
}

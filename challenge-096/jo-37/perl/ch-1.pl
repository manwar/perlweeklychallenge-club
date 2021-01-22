#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;    # does not return

say(<<EOS), exit unless @ARGV;
usage: $0 [-examples] [-tests] [--] [phrase...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

phrase...
   phrases to be reversed.  All given phrases will be concatenated.

EOS


### Input and Output

say qq{"@{reverse_words(@ARGV)}"};


### Implementation

# Return a reference to an array containing the reversed list of words.
sub reverse_words {
    local $_ = "@_";
    # Special split behaviour:
    # - removes leading whitspace when PATTERN is omitted or ' '
    # - uses /\s+/ as split pattern when omitted or ' '
    # - strips trailing empty fields when LIMIT is omitted or zero
    [reverse split];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is reverse_words('The Weekly Challenge'),
            [qw(Challenge Weekly The)], 'Example 1';
        is reverse_words('    Perl and   Raku are  part of the same family  '),
            [qw(family same the of part are Raku and Perl)], 'Example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is reverse_words(' a b'), [qw(b a)], 'strip leading whitespace';
        is reverse_words('a b '), [qw(b a)], 'strip trailing whitspace';
        is reverse_words('a  b'), [qw(b a)], 'trim intermediate whitespace';
        is reverse_words(qw(a b c)), [qw(c b a)], 'multiple args';
    }

    done_testing;
    exit;
}

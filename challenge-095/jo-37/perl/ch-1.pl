#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use warnings FATAL => 'all';
use Scalar::Util 'looks_like_number';
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;    # does not return

say(<<EOS), exit unless @ARGV;
usage: $0 [-examples] [-tests] [--] [string]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print diagnostic information

string
    string to test if it represents a palindrome number

EOS

### Input and Output

my $ret = palindrome_number($ARGV[0]);

if ($verbose) {
    say "got $ARGV[0]" if $verbose;
    if (!defined $ret) {
        say 'is not a number';
    } else {
        say "has value ", 0 + $ARGV[0];
        if ($ret eq '') {
            say 'reverse value is not a number';
        } elsif ($ret) {
            say "is palindrome";
        } else {
            say "is not palindrome";
        }
    }
}

say 0 + !!$ret;

### Implementation

# The concept of "number palindromes" needs further specifications to be
# well defined because "palindromic" is a string property and there is no
# unique string representation of a number.  Following the examples I'll
# take the decimal representation of a number that has to form a palindrome.
# Though there seems to be some consensus on considering integer numbers
# only, *any* numeric value is allowed here.
#
# A string shall be considered as palindromic number, iff the
# transformation chain
#   numify->stringify->reverse->numify->stringify 
# resembles the input string. (All transformations from a Perl view.)
#
# This sub uses different false return values to signal the failed test:
# - undef for a non-numeric input string
# - the empty string for a non-numeric reversed numified input string
# - zero for a numeric forward and backward value that is not a palindrome
#   number
sub palindrome_number ($str) {
    return unless looks_like_number $str;
    my $reverse = reverse $str + 0;
    return '' unless looks_like_number $reverse;

    0 + ($str eq $reverse + 0);
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        ok palindrome_number(1221), 'example 1: 1221 is palindrome';
        ok !palindrome_number(-101), 'example 2: -101 is not palindrome';
        ok !palindrome_number(90), 'example 3: 90 is not palindrome';
    }

    SKIP: {
        skip "tests" unless $tests;
        for my $str (qw(21e12 1.221e3 0012100 00121 0012.2100)) {
            ok !palindrome_number($str), "$str is not palindrome";
        }
        for my $str (qw(12.21 1221)) {
            ok palindrome_number($str), "$str is palindrome";
        }

        # specific return codes
        is palindrome_number('1O2O1'), U(), 'not a number';
        is palindrome_number('-101'), '', 'reverse not a number';
        is palindrome_number('1e-21'), '', 'reverse not a number';
        is palindrome_number('12327'), 0, 'not palindrome';
        is palindrome_number('+121.0'), 0, 'not palindrome';
        is palindrome_number('121'), 1, 'palindrome';

        # exotic cases: NaN vs. nan
        is palindrome_number('NaN'), 0, 'NaN is numeric';
        is palindrome_number('nan'), 1, 'possibly the strangest case';
    }

    done_testing;
    exit;
}

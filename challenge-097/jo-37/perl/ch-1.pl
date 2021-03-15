#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples, $verbose, $offset);

run_tests() if $tests || $examples;    # does not return

say(<<EOS), exit unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [-offset=n] [text...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    show cipher

-offset=n
    Use n as cipher offset.  Default: 13

text...
    words to be encoded

EOS


### Input and Output

say caesar($offset // 13)->(@ARGV);


### Implementation

# Generate a Caesar Cipher encoder with offset n.  Use -n for a
# matching decoder.
sub caesar ($n) {
    state $plain = join '', 'A' .. 'Z';

    $n %= length $plain;
    my $cipher = $n ?
            # last $n chars + first chars except last $n chars.
            substr($plain, -$n, $n) . substr($plain, 0, -$n) :
            $plain;

    say "Offset: $n\nPlain:  $plain\nCipher: $cipher" if $verbose;

    # Encode string(s) using Caesar Cipher. All characters outside plain
    # capital latin letters and SPACE are silently discarded.  The SPACE
    # character will be passed unencoded.  Does not rely on a contiguous
    # character encoding of letters. (EBCDIC!)
    sub (@s) {
        local $_ = "@s";

        # tr/// does not interpolate.
        eval "tr/ $plain//cd";
        eval "tr/ $plain/ $cipher/r";
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is caesar(3)->('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG'),
            'QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD', 'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        # Create a set of encoders.
        my $clear= caesar(0);
        my $enc6 = caesar(6);
        my $dec6 = caesar(-6);

        is $clear->('ABCD'), 'ABCD', 'cleartext';
        is $enc6->('EFGH'), 'YZAB', 'wrap positive';
        is $dec6->('STUV'), 'YZAB', 'wrap negative';
        is $clear->('ABc dEF'), 'AB EF', 'discard illegal characters';
        is $clear->(qw(A B C D)), 'A B C D', 'multiple args';
        is $dec6->($enc6->('AB CD')), 'AB CD', 'encode/decode';
    }

    done_testing;
    exit;
}

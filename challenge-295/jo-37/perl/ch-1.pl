#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STR WORD...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    a string

WORD...
    list of words

EOS


### Input and Output

say +(qw(true false))[!word_break(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/15/ch-295.html#task-1


sub word_break {
    my $str = shift;
    my $words = join '|', map "\Q$_\E", @_;

    $str =~ /^(?:$words)*$/;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok word_break(weeklychallenge => qw(challenge weekly)),
            'example 1';
        ok word_break(perlrakuperl => qw(raku perl)),
            'example 2';
        ok !word_break(sonsanddaughters => qw(sons sand daughters)),
            'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok  word_break('AB|CD' => qw(A B|C D)), 'match meta';
        ok !word_break('ABCD'  => qw(A B|C D)), 'quoted meta';
    }

    done_testing;
    exit;
}

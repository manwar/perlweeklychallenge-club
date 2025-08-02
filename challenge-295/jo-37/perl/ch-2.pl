#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util 'min';
use Memoize;

memoize('jump_game');

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

I...
    list of integers

EOS


### Input and Output

main: {
    my $jg = jump_game(@ARGV);
    say $jg == 'inf' ? -1 : $jg;
}


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/15/ch-295.html#task-2


sub jump_game {
    return 1 if $_[0] >= $#_;
    return 'inf' if $_[0] == 0;

    1 + min map jump_game(@_[$_ .. $#_]), 1 .. $_[0];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is jump_game(2, 3, 1, 1, 4), 2, 'example 1';
        is jump_game(2, 3, 0, 4), 2, 'example 2';
        is jump_game(2, 0, 0, 4), float('inf'), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
    }

    done_testing;
    exit;
}

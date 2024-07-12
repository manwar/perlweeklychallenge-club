#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [--] [W11,w12,... W21,W22,...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    list common words instead of their count

W11,W12,... W21,W22,...
    comma separated lists of words

EOS


### Input and Output

main: {
    my @common = count_common(map [split /,/], @ARGV);
    say $verbose ? "(@common)" : scalar @common;
}


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/07/12/ch-277.html#task-1


sub count_common {
    my %words;
    my $li = $#_;
    for my $i (0 .. $li) {
        $words{$_}[$i]++ for $_[$i]->@*;
    }
    no warnings 'uninitialized';

    grep {$li + 1 == grep $_ == 1, $words{$_}->@[0..$li]} keys %words
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is scalar count_common(
            ["Perl", "is", "my", "friend"],
            ["Perl", "and", "Raku", "are", "friend"]
        ), 2, 'example 1';

        is scalar count_common(
            ["Perl", "and", "Python", "are", "very", "similar"],
            ["Python", "is", "top", "in", "guest", "languages"]
        ), 1, 'example 2';

        is scalar count_common(
            ["Perl", "is", "imperative", "Lisp", "is", "functional"],
            ["Crystal", "is", "similar", "to", "Ruby"]
        ), 0, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [count_common(
            [qw(one two two three four five)],
            [qw(one two three three four six)],
            [qw(one two three four four seven)]
        )], ['one'], 'three arrays with one common word';
	}

    done_testing;
    exit;
}

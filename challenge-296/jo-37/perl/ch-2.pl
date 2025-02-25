#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util qw(sum);
use experimental 'signatures';

use constant N => 4;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

N...
    list of numbers

EOS


### Input and Output

say +(qw(true false))[!make_square(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/22/ch-296.html#task-2

sub forselected ($sel, $exec, $n) {
    my @idx = 0;
    while () {
        my $c = $sel->(@idx);
        if (!defined $c) {
            pop @idx;
        } elsif (!$c) {
            ($exec->(@idx) && return 1) || pop @idx;
        } elsif ($c < 0) {
            push @idx, $idx[-1];
        }
        while () {
            return unless @idx;
            last if ++$idx[-1] < $n;
            pop @idx;
        }
    }
}

our $lvl;
sub dbg {
    say "  " x (($lvl // 1) - 1), @_ if $verbose;
}

sub make_square {
    my $sum = sum @_;

    dbg("stop: sum=$sum not divisible by ", N),
    return if $sum % N;

    local $lvl = 0;
    make_equal(N, $sum / N, sort {$b <=> $a} @_);
}


sub make_equal ($count, $length, @ints) {
    local $lvl = $lvl + 1;
    dbg "subsets: count=$count, sum=$length items=(@ints)";

    my %seen;
    my $sel = sub {
        dbg("stop: loop done"),
        return if $_[0] > 0;
        return 1 if $seen{"@ints[@_]"}++;

        sum(@ints[@_]) <=> $length;
    };
    my $exec = sub {
        dbg "got subset (@ints[@_])";

        dbg("all done"),
        return 1 if $count <= 2;

        my @rest = @ints;
        delete @rest[@_];
        @rest = grep defined, @rest;

        make_equal($count - 1, $length, @rest);
    };

    forselected($sel, $exec, scalar @ints);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        
        ok  make_square(1, 2, 2, 2, 1),    'example 1';
        ok !make_square(2, 2, 2, 4),       'example 2';
        ok !make_square(2, 2, 2, 2, 4),    'example 3';
        ok  make_square(3, 4, 1, 4, 3, 1), 'example 4'
    }

    SKIP: {
        skip "tests" unless $tests;

        ok  make_square(3, 3, 3, 3), 'trivial';
        ok  make_square(1 .. 15), 'sequence';
        ok  make_square(571, 362, 67, 413, 215, 372, 16, 457, 527, 1000),
            'backtrack';
        ok !make_square(3, 3, 2, 2, 2), 'fail fast';
        ok !make_square(3, 3, 2, 2, 2, map $_ * 4, 1 .. 15), 'try many';
    }

    done_testing;
    exit;
}

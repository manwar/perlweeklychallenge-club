#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples, $show);

run_tests() if $tests || $examples;	# does not return
show_strict() if $show;

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-show] [--] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-show
    show all strict solutions

N...
    ...

EOS


### Input and Output

say +(qw(true false))[!digit_count_number(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/08/23/ch-283.html#task-2


sub digit_count_number {
    my $l = long @_;
	my $d = long map split(//), @_;
    my ($cnt, $val) = rle $d->qsort;
    ($cnt, $val) = where $cnt, $val, $val < @_;
    my $freq = zeroes $l;
    $freq->index($val) .= $cnt;
    all $l == $freq;
}

BEGIN {
    @::strict_arr = (
        [1, 2, 1, 0],
        [2, 0, 2, 0],
        [2, 1, 2, 0, 0],
        [3, 2, 1, 1, 0, 0, 0],
        [4, 2, 1, 0, 1, 0, 0, 0],
        [5, 2, 1, 0, 0, 1, 0, 0, 0],
        [6, 2, 1, 0, 0, 0, 1, 0, 0, 0],
    );

    $::strict_re = qr{^(?:@{[join '|', map join(':', @$_), @::strict_arr]})$};
}

sub digit_count_number_strict {
    join(':', @_) =~ $::strict_re;
}

sub show_strict {
    say "(@$_)" for (@::strict_arr);
    exit;
}

### Examples and tests

use constant N => 8;

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  digit_count_number(1, 2, 1, 0), 'example 1';
        ok !digit_count_number(0, 3, 0), 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok digit_count_number(2, 0, 2, 0), 'l=4';
        ok digit_count_number(2, 1, 2, 0, 0), 'l=5';
        ok digit_count_number(3, 2, 1, 1, 0, 0, 0), 'l=7';
        ok digit_count_number(4, 2, 1, 0, 1, 0, 0, 0), 'l=8';
        ok digit_count_number(5, 2, 1, 0, 0, 1, 0, 0, 0), 'l=9';
        ok digit_count_number(6, 2, 1, (0) x 3, 1, 0, 0, 0), 'l=10';
        ok digit_count_number(7, 2, 1, (0) x 4, 1, 0, 0, 0), 'l=11';
        ok digit_count_number(8, 2, 1, (0) x 5, 1, 0, 0, 0), 'l=12';
        ok digit_count_number(9, 2, 1, (0) x 6, 1, 0, 0, 0), 'l=13';
        ok digit_count_number(10, 2, 1, (0) x 9), 'l=12';
        ok digit_count_number(11, 3, 0, 1, (0) x 10), 'l=14';
        ok digit_count_number(12, 3, 1, 1, (0) x 12), 'l=16';
        ok digit_count_number(14, 3, 0, 1, 1, (0) x 13), 'l=18';
        for my $p (0 .. 3) {
            my @a = (10**$p, 2, 1, (0) x (10**$p - $p));
            ok digit_count_number(@a), 10**$p . " zero(s)";
        }
        for my $strict (@::strict_arr) {
            ok digit_count_number_strict(@$strict), "strict: (@$strict)";
        }
        ok !digit_count_number_strict(7, 2, 1, (0) x 4, 1, 0, 0, 0),
            'strict l=11';
	}

    done_testing;
    exit;
}

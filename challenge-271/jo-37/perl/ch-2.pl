#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use Benchmark 'cmpthese';

our ($tests, $examples, $benchmark);

die "IV size of at least 48 bit required\n" if 48 > unpack '%b*', pack 'j', -1;

run_tests() if $tests || $examples || $benchmark;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-benchmark] [I...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-benchmark
    compare different implementations

I...
    list of integers

EOS


### Input and Output

say "(@{sort_by_one_bits(\@ARGV)})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/05/31/ch-271.html#task-2


sub sort_by_one_bits {
    map $_->[1],
    sort {$a->[0] <=> $b->[0] || $a->[1] <=> $b->[1]}
	map [unpack('%b*', pack 'l', $_), $_], @_;
}

sub sort_by_one_bits_idx {
    my @bc = unpack '(%b32)*', pack 'l*', @_;

    @_[sort {$bc[$a] <=> $bc[$b] || $_[$a] <=> $_[$b]} 0 .. $#_];
}

sub sort_by_one_bits_comp {
    my @bc = unpack '(%b32)*', pack 'l*', @_;

    unpack 'l*', pack 'L*',
    sort {$a <=> $b}
	map shift(@bc) << 40 | ($_ > 0) << 32 | (2**32 - 1) & $_, @_;
}

sub sort_by_one_bits_pdl {
    my $n = long @_;
    my $bc = long unpack '(%b32)*', $n->get_dataref->$*;

    $bc->dummy(0)->append($n->dummy(0))->qsortvec->((1));
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [sort_by_one_bits(0 .. 8)], [0, 1, 2, 4, 8, 3, 5, 6, 7],
            'example 1';

        is [sort_by_one_bits(1024, 512, 256, 128, 64)],
            [64, 128, 256, 512, 1024], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        my $given = [0, 1, 3, -2**31, -2**30];
        my @given = (0, 1, 3, -2**31, -2**30);
        my $expected = [0, -2**31, 1, -2**30, 3];
        is [sort_by_one_bits(@given)], $expected, 'straight';
        is [sort_by_one_bits_idx(@given)], $expected, 'index sort';
        is [sort_by_one_bits_comp(@given)], $expected, 'composite key';
        is sort_by_one_bits_pdl(@given)->unpdl, $expected, 'pdl';
    }


    SKIP: {
        skip "benchmark" unless $benchmark;

        my @n = (-2**15 .. 2**15-1);
        my $expected = [sort_by_one_bits(@n)];
        is [sort_by_one_bits_comp(@n)], $expected, 'cross comp';
        is [sort_by_one_bits_idx(@n)], $expected, 'cross idx';
        is sort_by_one_bits_pdl(@n)->unpdl, $expected, 'cross pdl';

        cmpthese(0, {
                st => sub {sort_by_one_bits(@n)},
                idx => sub {sort_by_one_bits_idx(@n)},
                comp => sub {sort_by_one_bits_comp(@n)},
                pdl => sub {sort_by_one_bits_pdl(@n)},
            });

        pass 'tests';
	}

    done_testing;
    exit;
}

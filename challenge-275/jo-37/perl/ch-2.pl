#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [AN]

-examples
    run the examples from the challenge
 
-tests
    run some tests

AN
    alpha-numeric string

EOS


### Input and Output

say replace_digits(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/06/28/ch-275.html#task-2

{
    my (@d2a, %a2i);
    BEGIN {
        @d2a = ('A' .. 'Z', 'a' .. 'z');
        @a2i{@d2a} = (0 .. $#d2a);
    }

    sub replace_digits {
        my $prev = 0;
        
        join '', map /\d/ ? $d2a[($prev + $_) % @d2a] :
            do {$prev = $a2i{$_} // die "Illegal char '$_'"; $_},
            split //, shift;
    }

}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is replace_digits('a1c1e1'), 'abcdef', 'example 1';
        is replace_digits('a1b2c3d4'), 'abbdcfdh', 'example 2';
        is replace_digits('b2b'), 'bdb', 'example 3';
        is replace_digits('a16z'), 'abgz', 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is replace_digits('a1C1e1'), 'abCDef', 'upper case';
        is replace_digits('Z1'), 'Za', 'wrap upper to lower';
        is replace_digits('z1'), 'zA', 'wrap lower to upper';
        is replace_digits('1C1'), 'BCD', 'leading digit';
        is replace_digits('a0'), 'aa', 'zero';
        like dies {replace_digits('a0+')}, qr/Illegal char/, 'illegal char';
	}

    done_testing;
    exit;
}

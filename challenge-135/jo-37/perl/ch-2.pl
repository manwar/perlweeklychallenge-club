#!/usr/bin/perl -s

use v5.18;
use Test2::V0;
use List::MoreUtils 'reduce_0';
use experimental qw(postderef regex_sets);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [S]

-examples
    run the examples from the challenge
 
-tests
    run some tests

S
    validate SEDOL code S.

EOS


### Input and Output

say 0 + validate_sedol(shift);


### Implementation

# To validate a SEDOL code, the check digit need not be calculated.  
#
# As the Wiki article states, all new SEDOLs start with a letter.
# Furthermore, the formula for the checksum - always producing a digit -
# restricts the final character.
# Checking:
# - seven digits
# or
# - no digit at start
# - six digits or uppercase vowels
# - followed by one digit
# and
# - weighted "digit" sum is a multiple of 10
#
# There are no special requirements for the character encoding in use.

BEGIN {
    my @weight = (1, 3, 1, 7, 3, 9, 1);
    (\my %value)->@{0 .. 9, 'A' .. 'Z'} = (0 .. 35);

    sub validate_sedol {
        local $_ = shift;

        /^ (?:
                \p{Digit} {7}
            |
                (?! \p{Digit} )
                (?[ \p{Digit} + \p{PosixUpper} - [AEIOU] ]) {6}
                \p{Digit}
            ) \z/ax &&
        !((reduce_0 {$a += $weight[$_] * $value{$b}} /./g) % 10);
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is validate_sedol('2936921'), T(), 'example 1';
        is validate_sedol('1234567'), F(), 'example 2';
        is validate_sedol('B0YBKL9'), T(), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is validate_sedol('0263494'), T(), 'BAE from Wiki';
        is validate_sedol('B000009'), T(), 'first new code';
        is validate_sedol('100001'),  F(), 'old too short';
        is validate_sedol('B00001'),  F(), 'new too short';
        is validate_sedol('10000090'), F(), 'old too long';
        is validate_sedol('B0000090'), F(), 'new too long';
        is validate_sedol('E000006'), F(), 'invalid char';
        is validate_sedol('B00000J'), F(), 'alpha checksum';
        is validate_sedol('1000009'), T(), 'weight at 0';
        is validate_sedol('0100007'), T(), 'weight at 1';
        is validate_sedol('0010009'), T(), 'weight at 2';
        is validate_sedol('0001003'), T(), 'weight at 3';
        is validate_sedol('0000107'), T(), 'weight at 4';
        is validate_sedol('0000011'), T(), 'weight at 5';
        is validate_sedol('BB00006'), T(), 'letters';
        is validate_sedol('B100006'), T(), 'mixed';
        is validate_sedol('0000000'), T(), 'checksum is linear';
        is validate_sedol('ZZZZZZ0'), T(), 'this is nice';
        is validate_sedol('1111111'), F(), 'old counterexample';
        is validate_sedol('BBBBBB1'), F(), 'new counterexample';
        is validate_sedol('0B00007'), F(), 'letter with starting digit';
        is validate_sedol('xB000009'), F(), 'anchor at beginning / old';
        is validate_sedol('x0000000'), F(), 'anchor at beginning / new';
        is validate_sedol('0000000x'), F(), 'anchor at end / old';
        is validate_sedol('B000009x'), F(), 'anchor at end / new';
        ok no_warnings {validate_sedol('Ä000000')}, 'exclude non-ASCII';

	}

    done_testing;
    exit;
}

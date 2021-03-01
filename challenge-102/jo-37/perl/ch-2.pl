#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental qw(signatures);
use Syntax::Keyword::Gather;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    generate hash-counting string of length N 

EOS


### Input and Output

say hashcountingstring($ARGV[0]);


### Implementation

# Collect hash positions from end and insert hash signs.
sub hashcountingstring ($n) {
    join('#', reverse gather {
            take '';
            for (; $n > 0; $n -= length($n) + 1) {
                take $n x ($n > 1);
            }
        });
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is hashcountingstring(1), '#', 'example a';
        is hashcountingstring(2), '2#', 'example b';
        is hashcountingstring(3), '#3#', 'example c';
        is hashcountingstring(10), '#3#5#7#10#', 'example d';
        is hashcountingstring(14), '2#4#6#8#11#14#', 'example e';
    }

    SKIP: {
        skip "tests" unless $tests;
        is hashcountingstring(11), '2#4#6#8#11#', '11';
        is hashcountingstring(12), '#3#5#7#9#12#', '12';
        is hashcountingstring(13), '#3#5#7#10#13#', '13';
	}

    done_testing;
    exit;
}

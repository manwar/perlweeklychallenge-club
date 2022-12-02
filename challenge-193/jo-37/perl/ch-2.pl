#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::MoreUtils 'slide';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STR...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR...
    Print the "odd ones" from the given strings.

EOS


### Input and Output

say for pick_odd(@ARGV);


### Implementation

# Some thoughts about this task:
# - There may be more or less than one "odd one".  Regarding a string as
#   odd if its difference array is unique.
# - The encoding of letters is irrelevant as long as it is contiguous
#   because the "difference array" then is independent therefrom.
# - The strings need not be of equal length.  A differing length gives a
#   differing "difference array" and thus makes an "odd one".

sub pick_odd {
    my %odd;
    # Split the string into an array of integers representing the ASCII
    # codes of its letters.  Slide over pairs and take the differences.
    # Store or undefine the string in %odd according to its difference
    # array as composite key.
    stou(\%odd, $_, slide {$b - $a} unpack 'c*', $_) for @_;

    # Pick the odd ones.
    grep defined, values %odd;
}

# STore Or Undefine:
# Store the value $val for a nonexisting composite key @key in the hash
# referenced by $href or remove the value (not the key!) otherwise.
sub stou ($href, $val, @key) {
    $href->{"@key"} = exists $href->{"@key"} ? undef : $val;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is [pick_odd(qw(adc wzy abc))], ['abc'], 'Example 1';
        is [pick_odd(qw(aaa bob ccc ddd))], ['bob'], 'Example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is [pick_odd(qw(abc abd abe))],
            bag {item 'abc'; item 'abd'; item 'abe'; end}, 'all odd';
        is [pick_odd(qw(abcd bcde cdef defg))], [], 'no odd one';
        is [pick_odd(qw(abm alm))],
            bag {item 'abm'; item 'alm'; end}, '[1, 11] != [11, 1]';
        is [pick_odd(qw(aa bb cc ddd))], ['ddd'], 'odd length';
	}

    done_testing;
    exit;
}

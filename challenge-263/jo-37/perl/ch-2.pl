#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use PDL::CCS;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [ITEMS...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

ITEMS...
    list of items arrays.  Each array has the form '[[i1, v1], [i2, v2],...]'
    Example 1 may be given as '[[1,1], [2,1], [3,2]]' '[[2,2], [1,3]]'
EOS
                                                                   
                                                                   
### Input and Output                                               
                                                                   
say merge_items(@ARGV);                                            
                                                                   
                                                                   
### Implementation
                                                                   
sub merge_items {
	my @pdl = map pdl($_), @_;
    my $which = null->glue(0, map $_((0)), @pdl)->uniq;
    my $sum = PDL::CCS::Nd->newFromWhich($which->dummy(0), zeroes($which),
        missing => 'BAD');
    $sum->indexND($_(0)) += $_(1) for null->glue(1, @pdl)->dog;

    $which->cat($sum->whichVals)->xchg(0, 1);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is merge_items([[1,1], [2,1], [3,2]], [[2,2], [1,3]])->unpdl,
            [[1,4], [2,3], [3,2]], 'example 1';
        is merge_items([ [1,2], [2,3], [1,3], [3,2] ], [ [3,1], [1,3] ])->unpdl,
            [[1,8], [2,3], [3,3]], 'example 2';
        is merge_items([[1,1], [2,2], [3,3]], [[2,3], [2,4]])->unpdl,
            [[1,1], [2,9], [3,3]], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is merge_items([[1,1], [2,1]], [[1,2], [4,2]], [[1,4], [8,4]],
            [[1,8], [16,8]])->unpdl,
            [[1,15], [2,1], [4,2], [8,4], [16,8]], 'four lists';
	}

    done_testing;
    exit;
}

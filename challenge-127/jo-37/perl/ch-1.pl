#!/usr/bin/perl -s

use v5.16;
use PDL;
use Test2::V0 '!float';
use experimental qw(signatures postderef);

our ($tests, $examples, $verbose, $pdl);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [-pdl] [s1 s2]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print the intersection of the two sets

-pdl
    use PDL (instead of hash) implementation

s1 s1
    Two sets as lists of comma and/or space separated elements, e.g.
    $0 1,2,5,3,4 '4 6 7 8 9'

EOS


### Input and Output

main: {
    my $impl = $pdl ? \&intersect_pdl : \&intersect_hash;
    my @s = map [split qr/[,\s]\s*/, $_], @ARGV;

    if ($verbose) {
        say "(@{[$impl->(@s)]})";
    } else {
        say 0 + !$impl->(@s);
    }
}


### Implementation

# Not just checking if the two sets are disjoint.  Determining the
# actual intersection and providing it on request.

# The 'delete' function applied to a hash returns a list of the deleted
# values and an 'undef' for every to-be-deleted key that was not
# present.
# Constructing a hash of keys and values equal to the elements of one
# set and then deleting the keys corresponding to the other set results
# in a list of the elements of the intersection plus some 'undef's.
sub intersect_hash ($s1, $s2) {
    (\my %s1)->@{@$s1} = @$s1;
    grep defined, delete @s1{@$s2};
}

# PDL makes it even shorter.
sub intersect_pdl ($s1, $s2) {
    intersect(long($s1), long($s2))->list;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        for my $impl (\&intersect_hash, \&intersect_pdl) {
            {
                my @s1 = (1, 2, 5, 3, 4);
                my @s2 = (4, 6, 7, 8, 9);
                is [$impl->(\@s1, \@s2)], [4], 'example 1';
            }
            {
                my @s1 = (1, 3, 5, 7, 9);
                my @s2 = (0, 2, 4, 6, 8);
                is [$impl->(\@s1, \@s2)], [], 'example 2';
            }
        }
    }

    SKIP: {
        skip "tests" unless $tests;
        for my $impl (\&intersect_hash, \&intersect_pdl) {
            {
                my @s1 = (1, 2, 5, 3, 4);
                my @s2 = (5, 3, 2);
                is [$impl->(\@s1, \@s2)],
                    bag { item 2; item 3; item 5; end}, 
                    'true subset';
                is [$impl->(\@s2, \@s1)],
                    bag { item 2; item 3; item 5; end},
                    'true subset, swapped';
            }
            {
                my @s1 = (1, 3, 5, 7, 9);
                my @s2 = (2, 4, 6, 9, 7);
                is [$impl->(\@s1, \@s2)],
                    bag {item 7; item 9; end},
                    'multi element intersection';
                is [$impl->(\@s2, \@s1)],
                    bag {item 7; item 9; end},
                    'multi element intersection, swapped';
            }
        }
	}

    done_testing;
    exit;
}

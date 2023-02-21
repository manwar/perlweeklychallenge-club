#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use Math::Prime::Util qw(todigits fromdigits logint vecmax);
use PDL;
use PDL::NiceSlice;
use Benchmark 'cmpthese';

our ($tests, $examples, $verbose, $benchmark);

run_tests() if $tests || $examples || $benchmark;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-benchmark] [-verbose] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    trace processing

-benchmark
    compare implementations. Needs about 4GB RAM.

N...
    list of integers

EOS


### Input and Output

say max_xor_intersect(@ARGV);


### Implementation

# This is just an simplistic brute-force implementation with a time
# complexity of O(N^2).  Though is very fast, it is very memory
# consuming.
sub max_xor_cartesian {
	my $l = long @_;
    # Take the maximum of all pairwise xor'ed numbers.
    ($l->dummy(0) ^ $l->dummy(1))->maxover->maxover->sclr;
}

# The memory footprint of the above implementation may be reduced
# drastically by using two nested loops, performing an XOR between two
# elements and comparing the result to the current found maximum.
# Implementing this in pure Perl slows it down remarkably, though.
sub max_xor_pure {
    my $max = 0;
    for my $i (0 .. $#_ - 1) {
        for my $k ($i + 1 .. $#_) {
            my $xor = $_[$i] ^ $_[$k];
            $max = $xor if $xor > $max;
        }
    }
    $max;
}

# There should be a way to find the maximum other than by processing all
# element pairs.
#
# To reduce the number of pair operations, we maintain a list of set
# pairs holding indices into the number list.
# At each step of the procedure, any member from the first set of a
# pair, when XORed with any member of the second set, will result in
# a maximum value over some bits, starting with the most significant.
#
# The starting list is a single pair of sets with the first set holding
# the indices to all elements having a higest significant bit set and
# the second with this bit unset.  The bit position is the higest where
# both sets are not empty.
#
# Given a list of set pairs, for each pair two new pairs are
# constructed, such that the XOR over the next bit becomes maximal.
# Only pairs with both sets not empty are considered.
# If there is such an nonempty pair, the bit position in the final
# result is one and the new constructes list of pairs is carried to the
# next bit position. Otherwise the final result has a zero at this bit
# position and the original list of set pairs remains unaltered.
#
# As all sets in any list of set pairs are pairwise disjoint,
# the complexity of this algorithm is O(N * K) with N as the number of
# elements and K as the number of significant bits over all numbers.
# For constant K this would be O(N).
#
# For smaller lists, the full scan is much faster than this procedure.
# However, with 32K elements the set based approach outruns the full
# scan, which already needs about 4GB for a list of this size.  Beyond
# that, the scan approach seems to follow the linear increase but has no
# competitors any longer.  See benchmark results below.
# 

sub max_xor_intersect {
    # Find the most significant bit for the whole list.
    my $hbit = 1 + logint vecmax(@_), 2;
    say "hbit: $hbit" if $verbose;

    # Convert numbers to their binary digits from step 1.
    my $bits = byte map [todigits($_, 2, $hbit)], @_;
    say "bits: $bits" if $verbose;

    my $pairlist;
    my @num;
    my $val;
    # Loop over bit positions.
    for my $bit ($bits->xchg(0, 1)->dog) {
        say "bits: $bit" if $verbose;
        # Create initial pair list.
        if (!$pairlist) {
            my @which = which_both $bit;
            if (!$which[0]->isempty && !$which[1]->isempty) {
                if ($verbose) {
                    say "startpair:";
                    say for @which;
                }
                $pairlist = [[@which]];
                push @num, 1;
            }
            next;
        }
        my $newpairs;
        my $val = 0;
        # Loop over set pairs.
        for my $pair (@$pairlist) {
            if ($verbose) {
                say "processing pair:";
                say $_ for @$pair;
            }
            # Build two new pairs of sets, keep only non-empty pairs.
            for (0, 1) {
                my $newpair = [$pair->[0]->where($_ ^ $bit($pair->[0])),
                    $pair->[1]->where(!$_ ^ $bit($pair->[1]))];
                if (!$newpair->[0]->isempty && !$newpair->[1]->isempty) {
                    if ($verbose) {
                        say "found new pair:";
                        say for @$newpair;
                    }
                    push @$newpairs, $newpair;
                    $val = 1;
                }
            }
        }
        # Use the new pair list if it not empty.
        if ($val) {
            $pairlist = $newpairs;
        }
        # Record the bit value for the result.
        push @num, $val
    }
    say "numbits: [@num]" if $verbose;
    return fromdigits \@num, 2;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is max_xor_intersect(1, 2, 3, 4, 5, 6, 7), 7, 'example 1';
        is max_xor_intersect(2, 4, 1, 3), 7, 'example 2';
        is max_xor_intersect(10,5,7,12,8), 15, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        my @test = qw(87 103 119 115 119 118 71 71 67 83 82 86);
        is max_xor_intersect(@test), max_xor_cartesian(@test), 'cross check';
	}

    SKIP: {
        skip "benchmark" unless $benchmark;

        {
            no warnings 'once';
            $PDL::BIGPDL ||= 1;
        }
        local $verbose;
        for my $p (9, 12, 15) {
            say "N=", 2**$p;
            my @test = long(2**31 * random 2**$p)->list;
            my $max_xor_intersect = max_xor_intersect(@test);
            say "max=$max_xor_intersect";
            is $max_xor_intersect, max_xor_cartesian(@test), 'cross check 1';
            is max_xor_pure(@test), $max_xor_intersect, 'cross check 2';
            cmpthese(0, {
                    cartesian => sub {max_xor_cartesian(@test)},
                    intersect => sub {max_xor_intersect(@test)},
                    pure => sub {max_xor_pure(@test)},
                });
            print "\n";
        }
    }

    done_testing;
    exit;
}

__DATA__
# Seeded srand with seed '20230226' from local date.
ok 1 - skipped test # skip examples
ok 2 - skipped test # skip tests
N=512
max=2147478155
ok 3 - cross check 1
ok 4 - cross check 2
            Rate intersect      pure cartesian
intersect 33.0/s        --      -65%      -99%
pure      95.0/s      188%        --      -96%
cartesian 2584/s     7729%     2620%        --

N=4096
max=2147483128
ok 5 - cross check 1
ok 6 - cross check 2
            Rate      pure intersect cartesian
pure      1.51/s        --      -67%      -95%
intersect 4.53/s      201%        --      -86%
cartesian 33.4/s     2120%      638%        --

N=32768
max=2147483643
ok 7 - cross check 1
ok 8 - cross check 2
            (warning: too few iterations for a reliable count)
            (warning: too few iterations for a reliable count)
            (warning: too few iterations for a reliable count)
          s/iter      pure cartesian intersect
pure        43.2        --      -94%      -96%
cartesian   2.39     1704%        --      -20%
intersect   1.91     2162%       25%        --

1..8

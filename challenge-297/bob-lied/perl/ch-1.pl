#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 297 Task 1 Contiguous Array
#=============================================================================
# You are given an array of binary numbers, @binary.
# Write a script to return the maximum length of a contiguous subarray with
# an equal number of 0 and 1.
# Example 1 Input: @binary = (1, 0)
#           Output: 2
#   (1, 0) is the longest contiguous subarray with an equal number of
#   0 and 1.
# Example 2 Input: @binary = (0, 1, 0)
#           Output: 2
#   (1, 0) or (0, 1) is the longest contiguous subarray with an equal
#   number of 0 and 1.
# Example 3 Input: @binary = (0, 0, 0, 0, 0)
#           Output: 0
# Example 4 Input: @binary = (0, 1, 0, 0, 1, 0)
#           Output: 4
#=============================================================================

use v5.40;
#use feature 'class'; no warnings "experimental::class";
use Object::Pad;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

class BinaryVector {
    field $binary;

    method validate($array) {
        use List::Util qw/all/;
        die "Not a binary array" unless all { $_ == 0 || $_ == 1 } $array->@*
    }

    method set($array) { $self->validate($array); $binary = $array; return $self; }

    method longestContiguous() {
        # Change 0 to -1 in the vector
        my @bv = map { $_ == 0 ? -1 : 1 } $binary->@*;
        my %seen;
        my $max = 0;
        my $sum = 0;

        # Every time the sum is 0, that means every 1 has been cancelled by a -1.
        # Every time we see the same sum, that means we've added an equal number
        # of 1s and -1s
        for my ($i, $b) ( indexed @bv )
        {
            $sum += $b;

            if ( $sum == 0 )   # Entire array is balanced to this point
            {
                $max = $i+1;
                if ( $Verbose) { say "Balanced to sum=0 at $i, max=$max" }
            }

            if ( exists $seen{$sum} )
            {
                my $len = $i - $seen{$sum};
                $max = $len if ( $max < $len );
                if ( $Verbose) { say "Found $sum again at $i, seen=$seen{$sum} len=$len max=$max" }
            }
            else
            {
                $seen{$sum} = $i;
                if( $Verbose) { say "First see $sum at $i" }
            }
        }
        return $max
    }
}

say BinaryVector->new->set(\@ARGV)->longestContiguous();


sub runTest
{
    use Test2::V0;
    my $bv = BinaryVector->new();

    is( $bv->set([1,0        ])->longestContiguous(), 2, "Example 1");
    is( $bv->set([0,1,0      ])->longestContiguous(), 2, "Example 1");
    is( $bv->set([0,0,0,0,0  ])->longestContiguous(), 0, "Example 1");
    is( $bv->set([0,1,0,0,1,0])->longestContiguous(), 4, "Example 1");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

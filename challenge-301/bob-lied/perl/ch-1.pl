#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 301 Task 1 Largest Number
#=============================================================================
# You are given a list of positive integers, @ints.
# Write a script to arrange all the elements in the given list such that
# they form the largest number and return it.
# Example 1 Input: @ints = (20, 3) Output: 320
# Example 2 Input: @ints = (3, 30, 34, 5, 9) Output: 9534330
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say largestNumber(@ARGV);

sub largestNumber(@ints)
{
    my $largest = join("", @ints);

    @ints = sort { $b <=> $a } @ints;

    my @stack;
    for ( 0 .. $#ints )
    {
        my @remain = @ints;
        my $first = splice(@remain, $_, 1);
        push @stack, [ $first, [ @remain ], "" ];
    }
    while ( my $x = pop @stack )
    {
        my ($n, $remain, $sofar) = @$x;

        $sofar .= $n;
        if ( ! @$remain )
        {
            $largest = $sofar if $sofar > $largest;
            next;
        }

        for ( 0 .. $remain->$#* )
        {
            my @rest = $remain->@*;
            my $next = splice(@rest, $_, 1);
            push @stack, [ $next, [ @rest ], $sofar ];
        }
    }
    return $largest;
}

sub runTest
{
    use Test2::V0;

    is( largestNumber(20, 3),           320, "Example 1");
    is( largestNumber(3,30,34,5,9), 9534330, "Example 2");

    done_testing;
}

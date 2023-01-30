#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 186 Task 1 Zip List
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given two list @a and @b of same size.
# Create a subroutine sub zip(@a, @b) that merge the two list as shown in
# the example below.
# Example Input:  @a = qw/1 2 3/; @b = qw/a b c/;
#        Output: zip(@a, @b) should return qw/1 a 2 b 3 c/;
#                zip(@b, @a) should return qw/a 1 b 2 c 3/;
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# Note that the spec of zip(@a, @b) can't be directly implemented with
# signatures, because arrays flatten in the function call (you can't have
# two @ parameters -- the first one slurps up all the arguments).  To pass
# parameters that look like arrays, we have to provide a protoype
# (see perldoc perlsub).  The prototype allows us to pass array names
# with an @ sigil, but they are actually array references in the sub.
sub zip :prototype(\@\@)
{
    # The outer map is a loop to set the index of an element.
    # The inner map is an array dereference from each array at i.
    # @_ is the list of arrays that were passed as parameters.
    return map {  my $i = $_; map { $_->[$i] } @_ } } 0 .. $#{$_[0]};
}

my @a = qw/1 2 3/; my @b = qw/a b c/;

zip(@a, @b);

sub runTest
{
    use Test2::V0;

    my @a = qw/1 2 3/;
    my @b = qw/a b c/;
    my @r = zip(@a, @b);
    is( \@r, [1, 'a', 2, 'b', 3, 'c'], "Example 1");
    @r = zip(@b, @a);
    is( \@r, ['a', 1, 'b', 2, 'c', 3], "Example 2");

    done_testing;
}


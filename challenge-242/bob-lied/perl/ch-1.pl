#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 242 Task 1 Missing Members
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given two arrays of integers.
# Write a script to find out the missing members in each other arrays.
# Example 1 Input: @arr1 = (1, 2, 3) @arr2 = (2, 4, 6)
#           Output: ([1, 3], [4, 6])
#   (1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
#   (2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).
#
# Example 2 Input: @arr1 = (1, 2, 3, 3) @arr2 = (1, 1, 2, 2)
#           Output: ([3])
#   (1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2).
#   Since they are same, keep just one.
#   (1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).
# -----
# In example 2, it seems like there should be an empty array to show that
# the first array has no missing members, but instead the emtpy array is
# suppressed. Taking that as the requirement.
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# Supply two arguments as quoted strings.
my @Arr1 = split(" ", $ARGV[0]);
my @Arr2 = split(" ", $ARGV[1]);
die qq(Usage: $0 "1 2 3" "3 4 5") unless @Arr1 && @Arr2;
say toString( missingMembers(\@Arr1, \@Arr2) );

# Turn an array-of-arrays reference into a bracketed string
sub toString($aoa)
{
    my $str = "("
            . join(", ", map { "[" . join(", ", $_->@*) . "]" } $aoa->@*)
            . ")";
}

sub missingMembers($arr1, $arr2)
{
    # For each element of both arrays, note whether it occurs in
    # the first array or the second by setting a bit.
    # Each value of the hash will be 1, 2, or 3 if the member
    # is in both arrays.
    my %memberOf;
    $memberOf{$_} |= 1 for $arr1->@*;
    $memberOf{$_} |= 2 for $arr2->@*;

    # Create an array of arrays, with four rows.
    my @missing;

    # Move each member to one of the arrays, using the bits we set above.
    # $missing[0] will be unused
    # $missing[1] has the members that are only in arr1
    # $missing[2] has the members that are only in arr2
    # $missing[3] has the members that are in both.
    # The sort is here so that the result matches the example order.
    for my $m ( sort { $a <=> $b } keys %memberOf )
    {
        push @{$missing[$memberOf{$m}]}, $m;
    }

    # Using a hash slice, return an array of array references for
    # the members that are exclusively in one array or the other.
    # Example 2 shows that we suppress empty arrays, hence the grep.
    return [ grep { defined } @missing[1,2] ];
}

sub runTest
{
    use Test2::V0;

    is( toString([[]]), "([])", "a of a one empty");
    is( toString([[5,6,7]]), "([5, 6, 7])", "a of a not empty");
    is( toString([[],[]]), "([], [])", "a of a empties");
    is( toString([[1],[2]]), "([1], [2])", "a of a singles");
    is( toString([[1,2],[3,4]]), "([1, 2], [3, 4])", "a of a doubles");

    is( missingMembers( [1,2,3], [2,4,6] ), [[1,3],[4,6]], "Example 1");
    is( missingMembers( [1,2,3,3], [1,1,2,2] ), [[3]], "Example 2");

    is( missingMembers( [1,1,2,2],[1,2,3,3] ), [[3]], "First empty");

    done_testing;
}

#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 213 Task 1 Fun Sort 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of positive integers.
# Write a script to sort the all even integers first then all odds in
# ascending order.
# Example 1 Input: @list = (1,2,3,4,5,6) Output: (2,4,6,1,3,5)
# Example 2 Input: @list = (1,2)         Output: (2,1)
# Example 3 Input: @list = (1)           Output: (1)
#=============================================================================

use v5.36;

use Getopt::Long;
my $DoTest  = 0;

GetOptions("test" => \$DoTest);
exit(!runTest()) if $DoTest;

say "(", join(",", funSort(@ARGV)->@*), ")";

# Single sort with separation in sort function
sub funSort(@list)
{
    return [ sort { (($a & 1) <=> ($b & 1)) || ($a <=> $b) } @list ];
}

# Sort, then partition
sub funSort_part(@list)
{
    use List::MoreUtils qw/part/;
    use List::Flatten qw/flat/;

    return [ grep { defined } flat part { $_ % 2 } sort { $a <=> $b} @list ];
}

# Partition, then sort each piece
sub funSort_partB(@list)
{
    use List::MoreUtils qw/part/;
    my @sorted;
    for my $sub ( part { $_ % 2} @list )
    {
        next unless defined $sub;
        push @sorted, sort { $a <=> $b } $sub->@*;
    }
    return \@sorted;
}

sub runTest
{
    use Test2::V0;

    is( funSort(1,2,3,4,5,6), [2,4,6,1,3,5], "Example 1");
    is( funSort(1,2        ), [2,1],         "Example 2");
    is( funSort(1          ), [1  ],         "Example 3");
    is( funSort(3,7,5,9,1  ), [1,3,5,7,9],   "Odds");
    is( funSort(2          ), [2  ],         "Evens 1");
    is( funSort(2,8,4,6    ), [2,4,6,8],     "Evens 2");

    is( funSort_part(1,2,3,4,5,6), [2,4,6,1,3,5], "Example 1");
    is( funSort_part(1,2        ), [2,1],         "Example 2");
    is( funSort_part(1          ), [1  ],         "Example 3");
    is( funSort_part(3,7,5,9,1  ), [1,3,5,7,9],   "Odds");
    is( funSort_part(2          ), [2  ],         "Evens 1");
    is( funSort_part(2,8,4,6    ), [2,4,6,8],     "Evens 2");

    is( funSort_partB(1,2,3,4,5,6), [2,4,6,1,3,5], "Example 1");
    is( funSort_partB(1,2        ), [2,1],         "Example 2");
    is( funSort_partB(1          ), [1  ],         "Example 3");
    is( funSort_partB(3,7,5,9,1  ), [1,3,5,7,9],   "Odds");
    is( funSort_partB(2          ), [2  ],         "Evens 1");
    is( funSort_partB(2,8,4,6    ), [2,4,6,8],     "Evens 2");

    done_testing;
}

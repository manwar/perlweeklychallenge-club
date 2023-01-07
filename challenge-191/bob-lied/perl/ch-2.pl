#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 191, Task 2 Cute List
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an integer, 0 < $n <= 15.
# Write a script to find the number of orderings of numbers that form a
# cute list.
# With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering
# of @list is cute if for every entry, indexed with a base of 1, either
#   1) $list[$i] is evenly divisible by $i
# or
#   2) $i is evenly divisible by $list[$i]
#
# Example Input: $n = 2 Ouput: 2
#   Since $n = 2, the list can be made up of two integers only i.e. 1 and 2.
#   Therefore we can have two list i.e. (1,2) and (2,1).
#   @list = (1,2) is cute since $list[1] = 1 is divisible by 1 and $list[2] = 2 is divisible by 2.
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

for my $n ( grep { 0 < $_ <= 15 } @ARGV )
{
    say cuteList($n);
}

# Brute force would be to generate all the permutations and check
# each one, but 15! is ... a lot.  Better to generate the possibilities
# and count them.

sub cuteList($n)
{
    my $count = 0;
    my $cute = choose($n, 1, [ 1..$n ], \$count, [], "");
    return $count;
}

sub choose($n, $i, $avail, $count, $permutation, $indent)
{
    say "${indent}choose n=$n i=$i c=$$count avail=[@$avail] p=[@$permutation]" if $Verbose;
    if ( scalar(@$avail) == 0 )
    {
        say "${indent}Found permutation [ @$permutation ]" if $Verbose;
        $$count++;
        say "${indent}Progress: count=$$count" if $Verbose && $$count%1000==0;
        return 1;
    }
    return 0 if ( $i > $n );

    my @canFill = grep { $i % $avail->[$_] == 0 || $avail->[$_] % $i == 0 } 0 .. (scalar(@$avail-1));

    return 0 if ( @canFill == 0 );

    for ( @canFill )
    {
        my $subset = [ $avail->@* ]; # clone
        my $p = [ $permutation->@*, $avail->[$_] ];
        splice(@$subset, $_, 1);
        choose($n, $i+1, $subset, $count, $p, "  $indent");
    }
}


sub runTest
{
    use Test2::V0;

    is( cuteList( 2),     2, "Example 1");
    is( cuteList( 1),     1, "Example 2");
    is( cuteList( 3),     3, "Example 3");
    is( cuteList( 4),     8, "Example 4");
    is( cuteList( 5),    10, "Example 5");
    is( cuteList(10),   700, "Example 10");
    is( cuteList(12),  4010, "Example 12");
    is( cuteList(15), 24679, "Example 15");

    done_testing;
}


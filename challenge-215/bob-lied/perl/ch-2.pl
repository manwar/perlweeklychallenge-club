#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Number Placement 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of numbers having just 0 and 1. You are also given
# placement count (>=1).
# Write a script to find out if it is possible to replace 0 with 1 in the
# given list. The only condition is that you can only replace when there is
# no 1 on either side. Print 1 if it is possible otherwise 0.
# Example 1: Input: @numbers = (1,0,0,0,1), $count = 1 Output: 1
# Example 2: Input: @numbers = (1,0,0,0,1), $count = 2 Output: 0
# Example 3: Input: @numbers = (1,0,0,0,0,0,0,0,1), $count = 3 Output: 1
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;
my $Count   = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "count:i" => \$Count);
exit(!runTest()) if $DoTest;

sub usage { "Usage: $0 -c COUNT [1|0]..." }

my @list = @ARGV;

do { say usage(); exit 1; } if @list == 0 || grep !/^[01]$/,  @list;

if ( $Verbose )
{
    my $copy =  [ @list ];
    my $canReplace = numberPlacement($copy, $Count);
    say $canReplace;
    say STDERR "(@list) --> $Count replacements\n(@$copy)" if $canReplace;
}
else
{
    say numberPlacement(\@list, $Count);
}


sub numberPlacement($list, $count)
{
    for ( my $i = 2;  $count && $i <= $list->$#* ; $i++ )
    {
        if ( $list->[$i-2] == 0 && $list->[$i-1] == 0 && $list->[$i] == 0 )
        {
            $list->[$i-1] = 1;
            $count--;
        }
    }
    return ( $count == 0 ? 1 : 0 );
}

sub runTest
{
    use Test2::V0;

    is(numberPlacement([1,0,0,0,1],         1), 1, "Example 1");
    is(numberPlacement([1,0,0,0,1],         2), 0, "Example 2");
    is(numberPlacement([1,0,0,0,0,0,0,0,1], 3), 1, "Example 3");
    is(numberPlacement([0,0,1],             1), 0, "Small fail");
    is(numberPlacement([0,0,0],             1), 1, "Small success");
    is(numberPlacement([1,0  ],             2), 0, "Too small");
    is(numberPlacement([0,0,1,0,0,1,0,0,1], 2), 0, "No cigar");
    is(numberPlacement([0,0,0,0,0,1,0,0,1], 2), 1, "Two cigars");
    is(numberPlacement([0,0,0,0,0,0,0,0,0], 4), 1, "Four cigars");
    is(numberPlacement([0,0,0,0,0,0,0,0,0], 5), 0, "Don't get greedy");

    done_testing;
}

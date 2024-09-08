#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 285 Task 1 No Connection
#=============================================================================
# You are given a list of routes, @routes.
# Write a script to find the destination with no further outgoing connection.
# Example 1 Input: @routes = (["B","C"], ["D","B"], ["C","A"])
#           Output: "A"
#   "D" -> "B" -> "C" -> "A".
#   "B" -> "C" -> "A".
#   "C" -> "A".
#   "A".
# Example 2 Input: @routes = (["A","Z"])
#           Output: "Z"
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say noConnection( (["B","C"],["D","B"],["C","A"]) );

sub noConnection(@routes)
{
    my %graph;
    for my $edge ( @routes )
    {
        my ($head, $tail) = $edge->@*;
        $graph{$head}{out}++;
        $graph{$tail}{in}++;
    }
    my @sink = grep { ! exists $graph{$_}{out} } keys %graph;
    return "" if @sink == 0;
    return wantarray ? @sink : $sink[0];
}

sub runTest
{
    use Test2::V0;

    is( noConnection( (["B","C"],["D","B"],["C","A"]) ), "A", "Example 1");
    is( noConnection( (["A","Z"]) ), "Z", "Example 2");

    my @sink =  noConnection( (["A","B"],["C","D"]) );
    is( \@sink, bag { item "B"; item "D"; end() }, "Multiple sinks");

    like( scalar(noConnection( (["A","B"],["C","D"]) )), qr/[BD]/, "scalar");

    is( noConnection( ["Z","X"], ["X","Z"] ), "", "No sink");

    done_testing;
}

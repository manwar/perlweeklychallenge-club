#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 344 Task 2  Array Formation
#=============================================================================
# You are given two lists: @source and @target.
# Write a script to see if you can build the exact @target by putting
# the smaller lists from @source together in some order. You cannot break
# apart or change the order inside any of the smaller lists in @source.
#
# Example 1 Input: @source = ([2,3], [1], [4]) @target = (1, 2, 3, 4)
#           Output: true
# Example 2 Input: @source = ([1,3], [2,4]) @target = (1, 2, 3, 4)
#           Output: false
# Example 3 Input: @source = ([9,1], [5,8], [2]) @target = (5, 8, 2, 9, 1)
#           Output: true
# Example 4 Input: @source = ([1], [3]) @target = (1, 2, 3)
#           Output: false
# Example 5 Input: @source = ([7,4,6]) @target = (7, 4, 6)
#           Output: true
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

my @TARGET = split(/[^0-9]+/, pop @ARGV);
my @SOURCE = map { [ split(/[^0-9]+/, $_) ] } @ARGV;
say canMake(\@SOURCE, \@TARGET) ? "true" : "false";

#=============================================================================

sub canMake($source, $target)
{
    my @stack = ( [ [ $source->@* ], [ $target->@*] ] );
    while ( @stack )
    {
        my ($s, $t) = pop(@stack)->@*;

        for my ($i, $p) (indexed $s->@* )
        {
            next unless isPrefix($p, $t);

            my @t = $t->@*;     # Make a copy of remaining target.
            splice(@t, 0, @$p); # Remove prefix from target.

            # Have we completely matched the target?
            if ( @t == 0 )
            {
                $logger->debug("YES: Left in source: ", scalar(@$source) );
                # Returning here regardless of what's left in source.
                # If the requirement was to use all of source, we would
                # check that the size of s is now down to 1.
                return true;
            }

            my @s = $s->@*;     # Make a copy of remaining source.
            splice(@s, $i, 1);  # Remove the segment we used.

            push @stack, [ \@s, \@t ];  # Try again with smaller sets.
        }
    }
    $logger->debug("NO: Left in source: ", scalar(@$source) );
    return false;
}

sub isPrefix($s, $t)
{
    return false if @$s > @$t;
    my $match = true;
    for my ($i, $n) ( indexed $s->@* )
    {
        $match &&= ($n == $t->[$i]);
    }
    return $match;
}

sub runTest
{
    use Test2::V0;

    is( isPrefix([1], [1,2,3]), true, "isPrefix 1");
    is( isPrefix([1,2], [1,2,3]), true, "isPrefix 2");
    is( isPrefix([1,2,3], [1,2,3]), true, "isPrefix 3");
    is( isPrefix([7,2,3], [1,2,3]), false, "isPrefix 4");
    is( isPrefix([1,2,7], [1,2,3,4]), false, "isPrefix 5");
    is( isPrefix([1,2,3,4], [1,2,3]), false, "isPrefix 6");

    is( canMake( [[2,3],[1],[4]]  , [1,2,3,4]  ),  true, "Example 1");
    is( canMake( [[1,3],[2,4]]    , [1,2,3,4]  ), false, "Example 2");
    is( canMake( [[9,1],[5,8],[2]], [5,8,2,9,1]),  true, "Example 3");
    is( canMake( [[1],[3]]        , [1,2,3]    ), false, "Example 4");
    is( canMake( [[7,4,6]]        , [7,4,6]    ),  true, "Example 5");

    is( canMake( [[1,4],[1,3],[1,2],[1,1]], [1,1,1,2,1,3,1,4] ), true, "bigger");
    is( canMake( [[1,4],[1,3],[1,2],[1,1]], [1,0,1,1,2,1,3,1,4] ), false, "bigger fail");
    is( canMake( [ [1,7,3], [4,5], [1,7], [3,4,5], [3], [4] ], [1,7,3,4] ), true, "backtrack");
    is( canMake( [ [1,7,3], [4,5], [1,7], [3,4,5], [3,4,6] ], [1,7,3,4] ), false, "backtrack fail");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });

}

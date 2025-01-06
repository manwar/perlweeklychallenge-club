#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 303 Task Delete and Earn
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to return the maximum number of points you can earn
# by applying the following operation some number of times.
# Pick any ints[i] and delete it to earn ints[i] points.
# Afterwards, you must delete every element equal to ints[i] - 1
# and every element equal to ints[i] + 1.
#
# Example 1 Input: @ints = (3, 4, 2)
#           Output: 6
#   Delete 4 to earn 4 points, consequently, 3 is also deleted.
#   Finally delete 2 to earn 2 points.
#
# Example 2 Input: @ints = (2, 2, 3, 3, 3, 4)
#           Output: 9
#   Delete a 3 to earn 3 points. All 2's and 4's are also deleted too.
#   Delete a 3 again to earn 3 points.
#   Delete a 3 once more to earn 3 points.
#=============================================================================

use v5.40;
use List::Util qw/uniq/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

say deleteGame(@ARGV);

#=============================================================================
sub deleteGame(@ints)
{
    my $best = 0;

    # Depth-first search. Start by stacking each element as a possibility.
    my @stack;
    for my ($i, $n) ( indexed @ints )
    {
        # Make a copy of the list with one element removed.
        my @remain = @ints;
        splice(@remain, $i, 1);

        # On the stack: cumulative score, thing we're deleting, remaining list
        push @stack, [ 0, $n, [@remain] ];
        $logger->debug("PUSH 0, $n, [@remain]");
    }
    while ( my $x = pop @stack )
    {
        my ($score, $toDelete, $list) = $x->@*;
        $logger->debug("POP $toDelete, [@$list], score=$score");

        # Play the game: increment the score.
        $score += $toDelete;

        # Play the game: remove the adjoining values.
        my @remain = grep { $_ != $toDelete - 1 && $_ != $toDelete + 1 } @$list;

        if ( @remain == 0 )
        {
            $best = $score if $score > $best;
            $logger->debug("FINISH: score=$score best=$best");
            next;   # Nothing more to add to stack
        }
        # Stack up the remaining possibilities.
        for my ($i, $n) ( indexed @remain )
        {
            my @copy = @remain;
            splice(@copy, $i, 1);
            push @stack, [ $score, $n, [@copy] ];
            $logger->debug("PUSH $score, $n, [@copy]");
        }
    }
    return $best;
}

sub runTest
{
    use Test2::V0;

    is( deleteGame(5),           5, "Singleton");
    is( deleteGame(5,5,5,5),    20, "Repeats");
    is( deleteGame(3,4,2),       6, "Example 1");
    is( deleteGame(2,2,3,3,3,4), 9, "Example 2");

    done_testing;
}

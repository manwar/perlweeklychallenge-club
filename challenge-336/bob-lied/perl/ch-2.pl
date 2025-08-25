#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 336  Task 2 Final Score
#=============================================================================
# You are given an array of scores by a team.  Write a script to find the
# total score of the given team. The score can be any integer, +, C or D.
# The + adds the sum of previous two scores. The score C invalidates the
# previous score. The score D will double the previous score.
# Example 1 Input: @scores = ("5","2","C","D","+")
#           Output: 30
#   Round 1: 5
#   Round 2: 5 + 2
#   Round 3: 5 (invalidate the previous score 2)
#   Round 4: 5 + 10 (double the previous score 5)
#   Round 5: 5 + 10 + 15 (sum of previous two scores)
#   Total Scores: 30
#
# Example 2 Input: @scores = ("5","-2","4","C","D","9","+","+")
#           Output: 27
#   Round 1: 5
#   Round 2: 5 + (-2)
#   Round 3: 5 + (-2) + 4
#   Round 4: 5 + (-2) (invalidate the previous score 4)
#   Round 5: 5 + (-2) + (-4) (double the previous score -2)
#   Round 6: 5 + (-2) + (-4) + 9
#   Round 7: 5 + (-2) + (-4) + 9 + 5 (sum of previous two scores)
#   Round 8: 5 + (-2) + (-4) + 9 + 5 + 14 (sum of previous two scores)
#   Total Scores: 27
#=============================================================================

use v5.42;
use List::Util qw/sum0/;


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

say finalScore(@ARGV);

#=============================================================================
sub finalScore(@score)
{
    my $final = 0;
    my @stack;
    for my $in ( @score )
    {
        if    ( $in eq 'C' ) { pop @stack if @stack; }
        elsif ( $in eq 'D' ) { push @stack, 2*$stack[-1] if @stack; }
        elsif ( $in eq '+' ) { push @stack, $stack[-1] + $stack[-2] if @stack >= 2; }
        else                 { push @stack, $in; }
    }
    return sum0 @stack;
}

sub runTest
{
    use Test2::V0;

    is( finalScore(qw(5 2 C D +)), 30, "Example 1");
    is( finalScore(qw(5 -2 4 C D 9 + +)), 27, "Example 2");

    is( finalScore(qw(D 2)), 2, "Nonsense, initial D");
    is( finalScore(qw(C 3)), 3, "Nonsense, initial C");
    is( finalScore(qw(+ 3)), 3, "Nonsense, initial +");
    is( finalScore(qw(3 + 3)), 6, "Nonsense, + with one arg");
    is( finalScore(qw(1 2 3 C C C)), 0, 'Cancel everything');

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

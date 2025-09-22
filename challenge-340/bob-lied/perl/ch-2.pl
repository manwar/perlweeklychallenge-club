#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 340 Task 2  Ascending Numbers
#=============================================================================
# You are given a string, $str, is a list of tokens separated by a single
# space. Every token is either a positive number consisting of digits 0-9
# with no leading zeros, or a word consisting of lowercase English letters.
# Write a script to check if all the numbers in the given string are strictly
# increasing from left to right.
# Example 1 Input: $str = "The cat has 3 kittens 7 toys 10 beds"
#           Output: true
# Example 2 Input: $str = 'Alice bought 5 apples 2 oranges 9 bananas'
#           Output: false
# Example 3 Input: $str = 'I ran 1 mile 2 days 3 weeks 4 months'
#           Output: true
# Example 4 Input: $str = 'Bob has 10 cars 10 bikes'
#           Output: false
# Example 5 Input: $str = 'Zero is 0 one is 1 two is 2'
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

say (isAscending($_) ? "true" : "false") for @ARGV;

#=============================================================================
sub isAscending($str)
{
    my $isSorted = true;
    my @num = grep /^\d+$/, split(" ", $str);
    while ( defined(my $n = shift @num) && @num)
    {
        $isSorted &&= ($n < $num[0]);
    }
    return $isSorted;
    # I'm taking the position that all lists are ascending unless
    # proved otherwise, hence a list of 0 or 1 returns true.
}

sub isAscending_slide($str)
{
    use List::MoreUtils qw/slide/; use List::Util qw/all/;
    my @num = grep /^\d+$/, split(" ", $str);
    return (@num < 2 ? true : all { $_ } slide { $a < $b } @num);
}

sub isAscending_try($str)
{
    use List::MoreUtils qw/slide/; use List::Util qw/all/;
    # Slide will throw if it doesn't have at least 2 elements to work on.
    try { 
        all { $_ } slide { $a < $b } grep /^\d+$/, split(" ", $str);
    }
    catch ( $e ) {
        return ($e =~ m/slide/);
    }
}

sub runTest
{
    use Test2::V0;

    my @func = (
        [ loop => \&isAscending ],
        [ slide => \&isAscending_slide ],
        [ trycatch => \&isAscending_try ],
    );

    my @case = (
        ['The cat has 3 kittens 7 toys 10 beds',       true, "Example 1" ],
        ['Alice bought 5 apples 2 oranges 9 bananas', false, "Example 2" ],
        ['I ran 1 mile 2 days 3 weeks 4 months',       true, "Example 3" ],
        ['Bob has 10 cars 10 bikes',                  false, "Example 4" ],
        ['Zero is 0 one is 1 two is 2',                true, "Example 5" ],
        ['no numbers here',                            true, "Zero numbers" ],
        ['1 number here',                              true, "One numbers" ],
        ['is this7a number9',                          true, "All really numbers, empty" ],
        ['is 7 this8a number9 2',                     false, "Some not really numbers" ],
    );

    for ( @func )
    {
        my ($name, $subref) = $_->@*;
        foreach ( @case )
        {
            my ($arg, $expect, $comment) = $_->@*;
            is( $subref->($arg), $expect, "$name $comment");
        }
    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my @str = (
    'The cat has 3 kittens 7 toys 10 beds',
    'Alice bought 5 apples 2 oranges 9 bananas',
    'I ran 1 mile 2 days 3 weeks 4 months  Bob has 10 cars 10 bikes',
    'Zero is 0 one is 1 two is 2 three is 3 four is 4 five is 5 six is 6',
    'no numbers here',
    '1 number here',
    'is this7a number9',
    'is 7 this8a number9 2',

    join(" and ", 0..99),
    );
    cmpthese($repeat, {
            loop     => sub { isAscending($_) for @str },
            slide    => sub { isAscending_slide($_) for @str },
            trycatch => sub { isAscending_try($_) for @str },
        });
}

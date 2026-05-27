#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 067 Task 1  Number Combinations
#=============================================================================
# You are given two integers $m and $n. Write a script print all possible
# combinations of $n numbers from the list 1 2 3 … $m.  Every combination
# should be sorted i.e. [2,3] is valid combination but [3,2] is not.
# Example: Input: $m = 5, $n = 2
#          Output: [ [1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5] ]
#=============================================================================

use v5.42;


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

say $_ for @ARGV;   # TODO command line processing here

#=============================================================================
sub combo($m, $n)
{
    my @result;
    use Algorithm::Combinatorics qw/combinations/;
    my $iter = combinations( [1..$m], $n);
    while ( my $c = $iter->next() )
    {
        push @result, $c;
    }
    return \@result;
}

sub runTest
{
    use Test2::V0;

    is( combo(5,2),
        [ [1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5] ]
        , "Example");

    done_testing;
}

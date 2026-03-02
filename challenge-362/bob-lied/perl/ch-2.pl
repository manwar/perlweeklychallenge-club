#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 362 Task  Spellbound Sorting
#=============================================================================
# You are given an array of integers.  Write a script to return them in
# alphabetical order, in any language of your choosing. Default language is English.
# Example 1 Input: (6, 7, 8, 9 ,10)
#			Output: (8, 9, 7, 6, 10)
# Example 2 Input: (-3, 0, 1000, 99)
#			Output: (-3, 99, 1000, 0)
# Example 3 Input: (1, 2, 3, 4, 5)
#			Output: (5, 4, 1, 3, 2) for English language five, four, one, three, two
# Example 4 Input: (0, -1, -2, -3, -4)
#			Output: (-4, -1, -3, -2, 0)
# Example 5 Input: (100, 101, 102)
#			Output: (100, 101, 102)
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

say '(', join(',', spellbound(@ARGV)->@*), ')';

#=============================================================================
sub spellbound(@list)
{
    use Lingua::EN::Numbers qw(num2en);

    [ map { $_->[0] }
      sort { $a->[1] cmp $b->[1] }
      map { [$_ , num2en($_)] } @list
    ]   
}

sub runTest
{
    use Test2::V0;

    is( spellbound(  6,   7,    8,   9,  10), [8, 9, 7, 6, 10],    "Example 1");
    is( spellbound( -3,   0, 1000, 99      ), [-3, 99, 1000, 0],   "Example 2");
    is( spellbound(  1,   2,    3,   4,   5), [5, 4, 1, 3, 2],     "Example 3");
    is( spellbound(  0,  -1,   -2,  -3,  -4), [-4, -1, -3, -2, 0], "Example 4");
    is( spellbound(100, 101, 102           ), [100, 101, 102],     "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}


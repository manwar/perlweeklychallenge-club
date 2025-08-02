#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 329 Task 2  Nice String
#=============================================================================
# You are given a string made up of lower and upper case English letters only.
# Write a script to return the longest substring of the givent string which is
# nice. A string is nice if, for every letter of the alphabet that the string
# contains, it appears both in uppercase and lowercase.
# Example 1 Input: $str = "YaaAho"
#           Output: "aaA"
# Example 2 Input: $str = "cC"
#           Output: "cC"
# Example 3 Input: $str = "A"
#           Output: ""
#=============================================================================

use v5.40;
use English;

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

say nice2($_) for @ARGV;

#=============================================================================
sub nice($str)
{
    my $longest = 0;
    my $nice = "";
    while ( $str =~ m/(.)\1*/ig )
    {
        my $c = substr($MATCH, 0, 1);
        next unless index($MATCH, uc($c)) != -1 && index($MATCH, lc($c)) != -1;

        my $len = $LAST_MATCH_END[0] - $LAST_MATCH_START[0];
        if ( $len > $longest )
        {
            $longest = $len;
            $nice = $MATCH;
        }
    }
    return $nice;
}


sub runTest
{
    use Test2::V0;

    is( nice("YaaAho"), "aaA", "Example 1");
    is( nice("cC"    ), "cC",  "Example 2");
    is( nice("A"     ), "",    "Example 3");

    is( nice("XlllllY"), "", "No uppercase");
    is( nice("xUUUUUy"), "", "No lowercase");
    is( nice("XaaAAYbBbBbZcC"), "bBbBb", "Multiple possibilities");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 342 Task 1  Balance String
#=============================================================================
# You are given a string made up of lowercase English letters and digits only.
# Write a script to format the give string where no letter is followed by
# another letter and no digit is followed by another digit. If there are
# multiple valid rearrangements, always return the lexicographically smallest
# one. Return empty string if it is impossible to format the string.
# Example 1 Input: $str = "a0b1c2"
#           Output: "0a1b2c"
# Example 2 Input: $str = "abc12"
#           Output: "a1b2c"
# Example 3 Input: $str = "0a2b1c3"
#           Output: "0a1b2c3"
# Example 4 Input: $str = "1a23"
#           Output: ""
# Example 5 Input: $str = "ab123"
#           Output: "1a2b3"
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

say balance($_) for @ARGV;

#=============================================================================
sub balance($str)
{
    use List::MoreUtils qw/part mesh/;

    my @p = part { index("0123456789", $_) >= 0  } sort split(//, $str);
    # p[0] is letters, p[1] is digits

    return "" if abs($p[0]->$#* - $p[1]->$#*) > 1;

    return  join "", grep { defined } (( $p[0]->$#* > $p[1]->$#* )
                      ? mesh($p[0]->@*, $p[1]->@*)
                      : mesh($p[1]->@*, $p[0]->@*));
}

sub runTest
{
    use Test2::V0;

    is( balance("a0b1c2"),  "0a1b2c",  "Example 1");
    is( balance("abc12"),   "a1b2c",   "Example 2");
    is( balance("0a2b1c3"), "0a1b2c3", "Example 3");
    is( balance("1a23"),    "",        "Example 4");
    is( balance("ab123"),   "1a2b3",   "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

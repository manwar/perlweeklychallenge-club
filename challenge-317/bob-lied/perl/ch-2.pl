#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 317 Task 2 Friendly Strings
#=============================================================================
# You are given two strings.  Write a script to return true if swapping
# any two letters in one string match the other string, return false otherwise.
# Example 1 Input: $str1 = "desc", $str2 = "dsec"
#           Output: true
# Example 2 Input: $str1 = "fuck", $str2 = "fcuk"
#           Output: true
# Example 3 Input: $str1 = "poo", $str2 = "eop"
#           Output: false
# Example 4 Input: $str1 = "stripe", $str2 = "sprite"
#           Output: true
#=============================================================================

use v5.40;

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

say isFriend(@ARGV) ? "true" : "false";

#=============================================================================
sub isFriend($str1, $str2)
{
    if ( length($str1) != length($str2) )
    {
        return false;
    }
    elsif ( $str1 eq $str2 )
    {
        # There must be a repeated letter that can be swapped for itself
        use List::MoreUtils qw/duplicates/;
        return duplicates(split(//, $str1)) > 0;
    }
    else
    {
        # Make pairs of characters and check for differences.
        use List::Util qw/zip/;
        my @diff = grep { $_->[0] ne $_->[1] }
                        zip( [split(//, $str1)], [split(//, $str2)] );

        # There must be exactly two differences that can be swapped.
        return @diff == 2
            && $diff[0][0] eq $diff[1][1] && $diff[0][1] eq $diff[1][0];
    }
}

sub runTest
{
    use Test2::V0;

    is( isFriend("desc",   "dsec"  ),  true, "Example 1");
    is( isFriend("fuck",   "fcuk"  ),  true, "Example 2");
    is( isFriend("poo",    "eop"   ), false, "Example 3");
    is( isFriend("stripe", "sprite"),  true, "Example 4");

    is( isFriend("abcd",   "abXd"  ), false, "Different, but not swapped");
    is( isFriend("abcd",   "baXd"  ), false, "Different after one swap");
    is( isFriend("abcd",   "badc"  ), false, "More than one swap");
    is( isFriend("AAAA",   "AAAA"  ),  true, "Same with repeated letter");
    is( isFriend("WXYZ",   "WXYZ"  ), false, "Same with no repeat");

    done_testing;
}

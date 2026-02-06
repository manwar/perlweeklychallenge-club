#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 359 Task 2  String Reduction
#=============================================================================
# You are given a word containing only alphabets, Write a function that
# repeatedly removes adjacent duplicate characters from a string until
# no adjacent duplicates remain and return the final word.
# Example 1 Input: $word = "aabbccdd"
#			Output: ""
# Example 2 Input: $word = "abccba"
#			Output: ""
# Example 3 Input: $word = "abcdef"
#			Output: "abcdef"
# Example 4 Input: $word = "aabbaeaccdd"
#			Output: "aea"
# Example 5 Input: $word = "mississippi"
#			Output: "m"
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

say "LIST : ", rmvPairList($_) for @ARGV;
say "REGEX: ", rmvPairRE($_) for @ARGV;

#=============================================================================
sub rmvPairRE($str)
{
    while ( $str =~ s/(.)\1//g ) { }
    return $str;
}

sub rmvPairList($str)
{
    my @s = split(//, $str);

    my $hasPair = true;
    while ( $hasPair )
    {
        $hasPair = false;
        my @reduced = ();
        while ( defined ( my $c = shift @s) )
        {
            if ( @s == 0 )
            {
                # Don't lose the last unmatched character
                push @reduced, $c;
            }
            elsif ( $c ne $s[0] )
            {
                # No match, keep this one
                push @reduced, $c;
            }
            else
            {
                # Throw away a matching pair
                shift @s;
                $hasPair = true;
            }
        }
        @s = @reduced;
    }
    return join("", @s);
}

sub runTest
{
    use Test2::V0;

    is( rmvPairRE(   "aabbccdd"),       "", "Example 1 RE");
    is( rmvPairRE(     "abccba"),       "", "Example 2 RE");
    is( rmvPairRE(     "abcdef"), "abcdef", "Example 3 RE");
    is( rmvPairRE("aabbaeaccdd"),    "aea", "Example 4 RE");
    is( rmvPairRE("mississippi"),      "m", "Example 5 RE");

    is( rmvPairList(   "aabbccdd"),       "", "Example 1 List");
    is( rmvPairList(     "abccba"),       "", "Example 2 List");
    is( rmvPairList(     "abcdef"), "abcdef", "Example 3 List");
    is( rmvPairList("aabbaeaccdd"),    "aea", "Example 4 List");
    is( rmvPairList("mississippi"),      "m", "Example 5 List");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}


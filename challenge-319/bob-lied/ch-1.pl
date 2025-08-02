#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 319 Task 1 Word Count
#=============================================================================
# You are given a list of words containing alphabetic characters only.  Write
# a script to return the count of words either starting with a vowel or ending
# with a vowel.
# Example 1 Input: @list = ("unicode", "xml", "raku", "perl")
#           Output: 2
# Example 2 Input: @list = ("the", "weekly", "challenge")
#           Output: 2
# Example 3 Input: @list = ("perl", "python", "postgres")
#           Output: 0
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


#=============================================================================
sub vowelCount :prototype(@) (@list)
{
    return scalar grep /^[aieou]|[aeiou]$/i, @list
}
say vowelCount(@ARGV);

sub vowcnt :prototype(@) (@list)
{
    my %vowel = map { $_ => true } qw(a e i o u A E I O U);
    my $count = 0;
    for ( @list )
    {
        $count++ if exists($vowel{substr($_,  0, 1)})
                 || exists($vowel{substr($_, -1, 1)});
    
    }
    return $count;
}

sub runTest
{
    use Test2::V0;

    is( vowelCount( "unicode", "xml", "raku", "perl"), 2, "Example 1");
    is( vowelCount( "the", "weekly", "challenge"    ), 2, "Example 2");
    is( vowelCount( "perl", "python", "postgres"    ), 0, "Example 3");
    is( vowelCount( "even", "bob", "can", "eat"     ), 2, "Starts but no ends");
    is( vowelCount( "", "zerolength", "string", ""  ), 0, "Empty strings");
    is( vowelCount(                                 ), 0, "Empty list");

    is( vowcnt( "unicode", "xml", "raku", "perl"), 2, "Example 1");
    is( vowcnt( "the", "weekly", "challenge"    ), 2, "Example 2");
    is( vowcnt( "perl", "python", "postgres"    ), 0, "Example 3");
    is( vowcnt( "even", "bob", "can", "eat"     ), 2, "Starts but no ends");
    is( vowcnt( "", "zerolength", "string", ""  ), 0, "Empty strings");
    is( vowcnt(                                 ), 0, "Empty list");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;
    my @list = qw( When in the Course of human events it becomes necessary
                   for one people to dissolve the political bands which have
                   connected them with another and to assume among the powers
                   of the earth the separate and equal station to which the
                   Laws of Nature and of Nature's God entitle them a decent
                   respect to the opinions of mankind requires that they
                   should declare the causes which impel them to the separation.
    );

    cmpthese($repeat, {
            withRegex     => sub { vowelCount(@list) },
            withSubstring => sub { vowcnt(@list)},
        });
}

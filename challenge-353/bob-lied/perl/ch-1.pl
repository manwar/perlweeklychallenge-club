#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 353 Task 1  Max Words   
#=============================================================================
# You are given an array of sentences.  Write a script to return the maximum
# number of words that appear in a single sentence.
#
# Example 1 Input: @sentences = ("Hello world", "This is a test", "Perl is great")
#           Output: 4
# Example 2 Input: @sentences = ("Single")
#           Output: 1
# Example 3 Input: @sentences = ("Short", "This sentence has six words in total",
#                                "A B C", "Just four words here")
#           Output: 6
# Example 4 Input: @sentences = ("One", "Two parts", "Three part phrase", "")
#           Output: 3
# Example 5 Input: @sentences = ("The quick brown fox jumps over the lazy dog",
#                                "A",
#                                "She sells seashells by the seashore",
#                                "To be or not to be that is the question")
#           Output: 10
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

say maxWords(@ARGV);

#=============================================================================
sub maxWords(@sentence)
{
    use List::Util qw/max/;
    return max map { scalar(split(" ", $_)) } @sentence;
}

sub runTest
{
    use Test2::V0;

    is( maxWords("Hello world", "This is a test", "Perl is great"),  4, "Example 1");
    is( maxWords("Single"),                                          1, "Example 2");
    is( maxWords("Short", "This sentence has six words in total",
                  "A B C", "Just four words here"),                  7, "Example 3");
    is( maxWords("One", "Two parts", "Three part phrase", ""),       3, "Example 4");
    is( maxWords("The quick brown fox jumps over the lazy dog",
                  "A",
                  "She sells seashells by the seashore",
                  "To be or not to be that is the question"),       10, "Example 5");

    done_testing;
}

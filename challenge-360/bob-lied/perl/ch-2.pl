#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 360 Task 2  Word Sorter
#=============================================================================
# You are give a sentence.  Write a script to order words in the given
# sentence alphabetically but keeps the words themselves unchanged.
# Example 1 Input: $str = "The quick brown fox"
#           Output: "brown fox quick The"
# Example 2 Input: $str = "Hello    World!   How   are you?"
#           Output: "are Hello How World! you?"
# Example 3 Input: $str = "Hello"
#           Output: "Hello"
# Example 4 Input: $str = "Hello, World! How are you?"
#           Output: "are Hello, How World! you?"
# Example 5 Input: $str = "I have 2 apples and 3 bananas!"
#           Output: "2 3 and apples bananas! have I"
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

say sorter(@ARGV);

#=============================================================================
sub sorter($str)
{
    return join " ", sort { lc($a) cmp lc($b) } split(" ", $str);
}

sub runTest
{
    use Test2::V0;

    is( sorter("The quick brown fox"), "brown fox quick The", "Example 1");
    is( sorter("Hello    World!   How   are you?"), "are Hello How World! you?", "Example 2");
    is( sorter("Hello"), "Hello", "Example 3");
    is( sorter("Hello, World! How are you?"), "are Hello, How World! you?", "Example 4");
    is( sorter("I have 2 apples and 3 bananas!"), "2 3 and apples bananas! have I", "Example 5");

    done_testing;
}

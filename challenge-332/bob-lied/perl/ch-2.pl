#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 332 Task 2  Odd Letters
#=============================================================================
# You are given a string.  Write a script to find out if each letter in
# the given string appeared odd number of times.
# Example 1 Input: $str = "weekly"       # Output: false
# Example 2 Input: $str = "perl"         # Output: true
# Example 3 Input: $source = "challenge" # Output: false
#=============================================================================

use v5.42;
use feature 'keyword_all';
no warnings 'experimental::keyword_all';

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

say (oddLetter($_) ? "true" : "false") for @ARGV;

#=============================================================================
sub oddLetter($str)
{
    my %letter;
    $letter{$_}++ for split(//, $str);
    return all { $_ % 2 } values %letter;
}

sub runTest
{
    use Test2::V0;

    is( oddLetter("weekly"),    false, "Example 1");
    is( oddLetter("perl"),       true, "Example 2");
    is( oddLetter("challenge"), false, "Example 3");

    is( oddLetter("xaaabbbbb"),  true, "More than one");

    done_testing;
}

#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 186 Task 2 Unicode Makeover
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a string with possible unicode characters.
# Create a subroutine sub makeover($str) that replace the unicode
# characters with ascii equivalent. For this task, let us assume it
# only contains alphabets.
# Example 1 Input: $str = 'ÃÊÍÒÙ'; Output: 'AEIOU'
# Example 2 Input: $str = 'âÊíÒÙ'; Output: 'aEiOU'
#=============================================================================
#
# Reading perldoc perlunitut, perldoc perluniintro, and perldoc unicode
# should convince anyone that the only rational choice is to use a CPAN
# module that has already figured this out.  perluniintro says:
# "The long answer is that you need to consider character normalization
#  and casing issues: see Unicode::Normalize, Unicode Technical Report
#  #15, Unicode Normalization Forms <https://www.unicode.org/reports/tr15>
#  and sections on case mapping in the Unicode Standard"
#
# Even Unicode::Normalize requires understanding how to choose from several
# normalized forms, so I'm going with the even simpler (probably too simple,
# but okay for this problem) Text::Unidecode.

use v5.36;

use Text::Unidecode;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say makeover($_) for @ARGV;

sub makeover($str)
{
    return Text::Unidecode::unidecode($str);
}

sub runTest
{
    use Test2::V0;

    is( makeover('ÃÊÍÒÙ'), 'AEIOU', "Example 1");
    is( makeover('âÊíÒÙ'), 'aEiOU', "Example 2");

    done_testing;
}


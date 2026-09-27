#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 392 Task 2  Word Length Product
#=============================================================================
# You are given an array of strings.  Write a script to return the maximum
# value of len($words[i]) * len($words[j]) where the two words do not share
# common letters. If no such two words exist, return 0.
# Example 1 Input: @words = ("a", "ab", "abc", "d", "de", "def")
#           Output: 9
#   Two words are "abc" and "def".
# Example 2 Input: @words = ("a", "aa", "aaa", "aaaa")
#           Output: 0
#   Since no two words can be chosen without sharing letters, the result is 0.
# Example 3 Input: @words = ("meet", "app", "code", "sky", "bold")
#           Output: 16
#   Two words are "meet" and "bold".
# Example 4 Input: @words = ("a", "ab", "abc", "abcd", "efghi")
#           Output: 20
#   Two words are "abcd" and "efghi".
# Example 5 Input: @words = ("xyz", "w", "abcdefg", "hij")
#           Output: 21
#   Two words are "abcdefg" and "hij".
#=============================================================================

use v5.44;


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

say task(@ARGV);

#=============================================================================
use feature "class"; no warnings "experimental::class";
class Word
{
    field $word   :param :reader;

    field $value  :reader;
    field $myLetters;

    ADJUST {
        $value = length($word);

        use List::MoreUtils qw/uniq/;
        $myLetters = "[" . join("", uniq(split //, $word)) . "]";
    }

    method show() { "$word($value)$myLetters" }
    use overload '""' => sub { $_[0]->show() };

    method isDistinctFrom($other)
    {
        return scalar $other->word !~ m/$myLetters/;
    }
}

#=============================================================================
sub task(@words)
{
    my @wordList = map { Word->new(word => $_) } @words;
    $logger->debug("WORDS: @wordList");

    my $best = 0;
    while ( my $first = shift @wordList )
    {
        for my $second ( @wordList )
        {
            $logger->debug("Compare: $first $second");
            if ( $first->isDistinctFrom($second) )
            {
                my $prod = $first->value() * $second->value();
                $best = $prod if $prod > $best;
                $logger->debug("  Distinct: prod=$prod best=$best");
            }
        }
    }
    return $best;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task("a", "ab", "abc", "d", "de", "def"  ),  9, "Example 1");
    is( task("a", "aa", "aaa", "aaaa"            ),  0, "Example 2");
    is( task("meet", "app", "code", "sky", "bold"), 16, "Example 3");
    is( task("a", "ab", "abc", "abcd", "efghi"   ), 20, "Example 4");
    is( task("xyz", "w", "abcdefg", "hij"        ), 21, "Example 5");
    is( task("x", "ahghg", "bm", "abcdef"        ), 10, "Test 6");
    is( task("x", "ghghg", "nm", "abcdef"        ), 30, "Test 7");
    is( task("xyz"                               ),  0, "Test 8");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}


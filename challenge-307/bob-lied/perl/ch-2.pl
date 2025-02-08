#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 307 Task 2 Find Anagrams
#=============================================================================
# You are given a list of words, @words.
# Write a script to find any two consecutive words and if they are anagrams,
# drop the first word and keep the second. You continue this until there is
# no more anagrams in the given list and return the count of final list.
# Example 1 Input: @words = ("acca", "dog", "god", "perl", "repl")
#           Output: 3
#   Step 1: "dog" and "god" are anagrams, so drop "dog" and keep "god"
#            => ("acca", "god", "perl", "repl")
#   Step 2: "perl" and "repl" are anagrams, so drop "perl" and keep "repl"
#            => ("acca", "god", "repl")
# 
# Example 2 Input: @words = ("abba", "baba", "aabb", "ab", "ab")
#           Output: 2
#   Step 1: "abba" and "baba" are anagrams, so drop "abba" and keep "baba"
#            => ("baba", "aabb", "ab", "ab")
#   Step 2: "baba" and "aabb" are anagrams, so drop "baba" and keep "aabb"
#            => ("aabb", "ab", "ab")
#   Step 3: "ab" and "ab" are anagrams, so drop "ab" and keep "ab"
#            => ("aabb", "ab")
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

say findAnagram_general(@ARGV);

#=============================================================================
use Memoize;
memoize("canonical");
sub canonical($word)
{
    join "", sort split //, $word
}

sub findAnagram(@words)
{
    my @out = ( $words[0] );
    for my $i ( 0 .. $#words-1 )
    {
        if ( canonical($words[$i]) eq canonical($words[$i+1]) )
        {
            $out[-1] = $words[$i+1];
        }
        else
        {
            push @out, $words[$i+1]
        }
    }
    return scalar(@out);
}

sub fa(@words)
{
    my @out = ( my $first = shift @words );
    while ( defined(my $second = shift @words) )
    {
        if ( canonical($first) eq canonical($second) )
        {
            $out[-1] = $second;
        }
        else
        {
            push @out, $second;
        }
        $first = $second;
    }
    return scalar(@out);
}

# If the anagrams can appear anywhere, it amounts to finding all the unique ones.
# Despite the hashing overhead, this is twice as fast as the loops over pairs.
sub findAnagram_general(@words)
{
    my %base;
    $base{ canonical($_) }++ for  @words;
    return scalar %base;

}

sub runTest
{
    use Test2::V0;

    is( findAnagram("acca", "dog", "god", "perl", "repl"), 3, "Example 1");
    is( findAnagram("abba", "baba", "aabb", "ab", "ab"  ), 2, "Example 2");

    is( fa("acca", "dog", "god", "perl", "repl"), 3, "Example 1");
    is( fa("abba", "baba", "aabb", "ab", "ab"  ), 2, "Example 2");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;
    my @words = ( "aa" .. "iz", 'aa' .. 'iz');

    cmpthese($repeat, {
            forloop  => sub { findAnagram(@words) },
            shifting => sub { fa(@words) },
            general  => sub { findAnagram_general(@words) },
        });
}

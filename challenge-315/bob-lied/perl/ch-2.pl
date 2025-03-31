#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 2 Task Find Third
#=============================================================================
# You are given a sentence and two words.  Write a script to return all
# words in the given sentence that appear in sequence to the given two words.
# Example 1
#       Input: $sentence = "Perl is a my favourite language but Pythonyy is my favourite too."
#                 $first = "my"
#                $second = "favourite"
#       Output: ("language", "too")
#
# Example 2
#       Input: $sentence = "Barbie is a beautiful doll also also a beautiful princess."
#                 $first = "a"
#                $second = "beautiful"
#       Output: ("doll", "princess")
# Example 3
#       Input: $sentence = "we will we will rock you rock you.",
#                 $first = "we"
#                $second = "will"
#       Output: ("we", "rock")
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

say '(', join(',', findThird(@ARGV)), ')';

#=============================================================================
sub findThird($sentence, $first, $second)
{
    my @third = ( $sentence =~ m/$first $second (?=(\w+))/g );
    return \@third;
}

sub find2($sentence, $first, $second)
{
    my @word = split(/[[:space:][:punct:]]+/, $sentence);
    return [] if @word < 2;
    my @third;
    for ( 0 .. $#word -2 )
    {
        push @third, $word[$_+2] if ( $word[$_] eq $first && $word[$_+1] eq $second );
    }
    return \@third;
}

sub runTest
{
    use Test2::V0;

    is( find2('Perl is a my favourite language but Python is my favourite too.',
                   "my", "favourite"),
                [qw/language too/], "Example 1");

    is( find2('Barbie is a beautiful doll also also a beautiful princess.',
                   "a", "beautiful"),
                [qw/doll princess/], "Example 2");

    is( find2('we will we will rock you rock you',
                   "we", "will"),
                [qw/we rock/], "Example 3");

    is ( find2('abc def ghi jkl', 'xyz', 'mno'), [], "No match on first");
    is ( find2('abc def ghi jkl', 'def', 'mno'), [], "No match on second");
    is ( find2('plover xyzzy', 'plover', 'xyzzy'), [], "Not enough words");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            regex  => sub { find2('we will we will rock you rock you', 'we', 'will') },
            strcmp => sub { find2('we will we will rock you rock you', 'we', 'will') },
        });
}

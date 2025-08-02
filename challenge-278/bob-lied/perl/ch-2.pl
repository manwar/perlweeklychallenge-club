#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 278 Task 2 Reverse Word
#=============================================================================
# You are given a word, $word and a character, $char.
# Write a script to replace the substring up to and including $char with
# its characters sorted alphabetically. If the $char doesn’t exist then
# DON'T do anything.
# Example 1 Input: $str = "challenge", $char = "e"
#           Ouput: "acehllnge"
# Example 2 Input: $str = "programming", $char = "a"
#           Ouput: "agoprrmming"
# Example 3 Input: $str = "champion", $char = "b"
#           Ouput: "champion"
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say reverseWord($_) for @ARGV;

sub reverseWord($word, $char)
{
    my $p = index($word, $char);
    my $front = join('', sort split(//, substr($word, 0, $p+1)));
    my $back  = substr($word, $p+1);
    return "$front$back";
}

sub rw2($word, $char)
{
    my ($front, $back) = $word =~ m/(.*?$char)(.*$)/;
    return ( join('', sort split(//, ($front//'')) ) . ($back//$word) );
}

sub rw3($word, $char)
{
    my @front;
    my $back;
    my @letter = split('', $word);
    while ( defined(my $c = shift @letter) )
    {
        push @front, $c;
        if ( $c eq $char )
        {
            $back = join('', @letter);
            last;
        }
    }

    return ( ! $back ? $word : (join('', sort @front)) . $back );
}

sub runTest
{
    use Test2::V0;

    is( reverseWord("challenge", "e"),   "acehllnge",    "Example 1");
    is( reverseWord("programming", "a"), "agoprrmming",  "Example 2");
    is( reverseWord("champion", "b"),    "champion",     "Example 3");

    is( rw2("challenge", "e"),   "acehllnge",    "Example 1 rw2");
    is( rw2("programming", "a"), "agoprrmming",  "Example 2 rw2");
    is( rw2("champion", "b"),    "champion",     "Example 3 rw2");

    is( rw3("challenge", "e"),   "acehllnge",    "Example 1 rw3");
    is( rw3("programming", "a"), "agoprrmming",  "Example 2 rw3");
    is( rw3("champion", "b"),    "champion",     "Example 3 rw3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            rev_index => sub { reverseWord("programming", "a") },
            rev_re    => sub { rw2("programming", "a") },
            rev_stack => sub { rw3("programming", "a") },
        });
}


#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 394 Task 2  Alternatings Vowels Consonants
#=============================================================================
# You are given three strings containing English alphabetic characters.
# Find all the longest contiguous substrings common to all three strings
# that strictly alternate between vowels and consonants.
# Example 1 Input: @str = ("relocate", "delocate", "allocate")
#           Output: ("locate")
# Example 2 Input: @str = ("apple", "banana", "cherry")
#           Output: ()
# Example 3 Input: @str = ("navigate", "cavity", "gravity")
#           Output: ("avi")
# Example 4 Input: @str = ("pedalgia", "pedalboard", "pedantic")
#           Output: ("peda")
# Example 5 Input: @strings = ("schoolmaster", "schoolhouse", "schooling")
#           Output: ("ho", "ol")
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

say '(', join(",", task(@ARGV)->@*), ')';

#=============================================================================
sub task(@str)
{
    use List::Util qw/all/;

    # Look at the shortest string as the basis for substrings
    @str = sort { length($a) <=> length($b) } @str;
    my $base = shift @str;

    my %answer = ();
    my $longest = 0;

    SUBSTRING: for my $start ( 0 .. length($base)-2 )
    {
        # Start with longest substring so shorter ones can be skipped
        # once we've found an answer
        my $s = substr($base, $start);
        my $slength = length($s);
        while ( $slength && $slength >= $longest )
        {
            # Reduce all vowels and consonants to a single character
            # to simplify the regular expression
            (my $vcvc = lc($s)) =~ tr/abcdefghijklmnopqrstuvwxyz/VCCCVCCCVCCCCCVCCCCCVCCCCC/;
            if ( $vcvc =~ m/^(?: (?:VC)+V? | (?:CV)+C? )$/x )
            {
                if ( all { index($_, $s) > -1 } @str )
                {
                    $answer{$s} = $longest = length($s);
                }
            }
            $s = substr($s, 0, --$slength);
        }
    }
    return [ sort keys %answer ];
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task("relocate", "delocate", "allocate"        ), ["locate"],   "Example 1");
    is( task("apple", "banana", "cherry"               ), [],           "Example 2");
    is( task("navigate", "cavity", "gravity"           ), ["avi"],      "Example 3");
    is( task("pedalgia", "pedalboard", "pedantic"      ), ["peda"],     "Example 4");
    is( task("schoolmaster", "schoolhouse", "schooling"), ["ho", "ol"], "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

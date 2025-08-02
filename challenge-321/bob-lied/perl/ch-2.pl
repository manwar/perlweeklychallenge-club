#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 321 Task 2 Backspace Compare
#=============================================================================
# You are given two strings containing zero or more #.  Write a script to
# return true if the two given strings are same by treating # as backspace.
# Example 1 Input: $str1 = "ab#c" $str2 = "ad#c"
#           Output: true
#    For first string,  we remove "b" as it is followed by "#".
#   For second string, we remove "d" as it is followed by "#".
#   In the end both strings became the same.
#
# Example 2 Input: $str1 = "ab##" $str2 = "a#b#"
#           Output: true
#
# Example 3 Input: $str1 = "a#b" $str2 = "c"
#           Output: false
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

say bspCmp(@ARGV) ? "true" : "false";

#=============================================================================
sub bspCmp($str1, $str2)
{
    return bsp($str1) eq bsp($str2);
}

sub bsp($str)
{
    my @c = split(//, $str);
    my @out;
    for ( @c )
    {
        if ( $_ eq '#' )
        {
            pop @out;
        }
        else
        {
            push @out, $_;
        }
    }
    return join("", @out);
}

sub bspSTR($str)
{
    my $out = '';
    while ( (my $c = substr($str, 0, 1, '')) ne '' )
    {
        if ( $c eq '#' )
        {
            substr($out, -1, 1, '');
        }
        else
        {
            $out .= $c;
        }
    }
    return $out;
}

# Fastest
sub bspRE($str)
{
    while ( $str =~ s/[^#]#//g ) { };
    return $str =~ s/#+//gr;    # Leading or trailing might be left
}

sub runTest
{
    use Test2::V0;

    is( bsp('abc'),  'abc', 'No backspaces');
    is( bsp('#abc'), 'abc', 'Useless leading backspace');
    is( bsp('a###'), '',    'Superfluous backspaces');
    is( bsp('dab##c'), 'dc',    'RE multiple backspaces');
    is( bsp('dab##efg###c'), 'dc',    'RE multiple backspaces');

    is( bspSTR('abc'),  'abc', 'STR No backspaces');
    is( bspSTR('#abc'), 'abc', 'STR Useless leading backspace');
    is( bspSTR('a###'), '',    'STR Superfluous backspaces');
    is( bspSTR('dab##c'), 'dc',    'RE multiple backspaces');
    is( bspSTR('dab##efg###c'), 'dc',    'RE multiple backspaces');

    is( bspRE('abc'),  'abc', 'RE No backspaces');
    is( bspRE('#abc'), 'abc', 'RE Useless leading backspace');
    is( bspRE('a###'), '',    'RE Superfluous backspaces');
    is( bspRE('dab##c'), 'dc',    'RE multiple backspaces');
    is( bspRE('dab##efg###c'), 'dc',    'RE multiple backspaces');

    is( bspCmp("ab#c", "ad#c"),  true, "Example 1");
    is( bspCmp("ab##", "a#b#"),  true, "Example 2");
    is( bspCmp("a#b",   "c"  ), false, "Example 3");

    is( bspCmp("dab##c", "da#b#c"),  true, "Example 2+");


    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $str = 'abcdefghijklmnopqrstuvwxyz' x 5;
    for ( 1 .. 15 ) { substr($str, int(rand(length($str))), 1, '#') }
    

    cmpthese($repeat, {
            array  => sub { bsp($str) },
            string => sub { bspSTR($str) },
            regex  => sub { bspRE($str) }
        });
}

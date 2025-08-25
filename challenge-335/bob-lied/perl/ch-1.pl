#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 335 Task 1  Common Characters
#=============================================================================
# You are given an array of words. Write a script to return all characters
# that are in every word in the given array including duplicates.
# Example 1 Input: @words = ("bella", "label", "roller")
#           Output: ("e", "l", "l")
# Example 2 Input: @words = ("cool", "lock", "cook")
#           Output: ("c", "o")
# Example 3 Input: @words = ("hello", "world", "pole")
#           Output: ("l", "o")
# Example 4 Input: @words = ("abc", "def", "ghi")
#           Output: ()
# Example 5 Input: @words = ("aab", "aac", "aaa")
#           Output: ("a", "a")
#=============================================================================

use v5.42;
use feature 'keyword_all'; no warnings 'experimental::keyword_all';
use List::Util qw/min/;


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

say '("', join('", "', common(\@ARGV)->@*), '")';

#=============================================================================
sub common($word)
{
    my @common;
    for my $c ( split(//, shift @$word) )
    {
        if ( scalar(@$word) == grep /$c/, @$word )
        {
            push @common, $c;
            $_ =~ s/$c// for @$word;
        }
    }
    return \@common;
}

sub commonIndex($word)
{
    my @common;
    for my $c ( split(//, shift @$word) )
    {
        if ( all { index($_, $c) != -1 } @$word )
        {
            push @common, $c;
            $_ =~ s/$c// for @$word;
        }
    }
    return \@common;
}

sub commonFreq($word)
{
    my %freq;
    my @common;
    for my $w ( $word->@* )
    {
        $freq{$w}{$_}++ for split(//, $w);
    }

    for my $letter ( keys $freq{$word->[0]}->%* )
    {
        my $count = min(map { $_->{$letter} // 0 } values %freq);
        push @common, ($letter) x $count;
    }
    return [ sort @common ];
}

sub runTest
{
    use Test2::V0;

    is( common( [qw(bella label roller)] ) , [ qw(e l l) ], "Example 1");
    is( common( [qw(cool lock cook    )] ), [ qw(c o)   ], "Example 2");
    is( common( [qw(hello world pole  )] ) , [ qw(l o)   ], "Example 3");
    is( common( [qw(abd def ghi       )] ) , [           ], "Example 4");
    is( common( [qw(aab aac aaa       )] ), [ qw(a a)   ], "Example 5");

    is( commonIndex( [qw(bella label roller)] ), [ qw(e l l) ], "Example 1");
    is( commonIndex( [qw(cool lock cook    )] ), [ qw(c o)   ], "Example 2");
    is( commonIndex( [qw(hello world pole  )] ), [ qw(l o)   ], "Example 3");
    is( commonIndex( [qw(abd def ghi       )] ), [           ], "Example 4");
    is( commonIndex( [qw(aab aac aaa       )] ), [ qw(a a)   ], "Example 5");

    is( commonFreq( [qw(bella label roller)] ), [ qw(e l l) ], "Example 1");
    is( commonFreq( [qw(cool lock cook    )] ), [ qw(c o)   ], "Example 2");
    is( commonFreq( [qw(hello world pole  )] ), [ qw(l o)   ], "Example 3");
    is( commonFreq( [qw(abd def ghi       )] ), [           ], "Example 4");
    is( commonFreq( [qw(aab aac aaa       )] ), [ qw(a a)   ], "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    say 'With all common';
    cmpthese($repeat, {
            grep  => sub { common( [('xy') x 244] ) },
            index => sub { commonIndex( [('xy') x 244] ) },
            freq  => sub { commonFreq( [('xy') x 244] ) }
        });

    say 'With no common';
    cmpthese($repeat, {
            grep  => sub { common( [('aa' .. 'zz')] ) },
            index => sub { commonIndex( [('aa' .. 'zz')] ) },
            freq  => sub { commonFreq( [('aa' .. 'zz')] ) }
        });

    say 'With long strings';
    my @word = ( 'a' x 1000 );
    foreach ( 'a' .. 'z' ) { push @word, ($_ x 999) . 'a' }
    cmpthese($repeat, {
            grep  => sub { common( [ @word ] ) },
            index => sub { commonIndex( [ @word ] ) },
            freq  => sub { commonFreq( [ @word ] ) }
        });
}

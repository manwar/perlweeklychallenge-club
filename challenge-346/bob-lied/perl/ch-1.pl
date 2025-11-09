#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 346 Task 1  Longest Parenthesis
#=============================================================================
# You are given a string containing only ( and ).
# Write a script to find the length of the longest valid parenthesis.
# Example 1 Input: $str = '(()())'
#           Output: 6
#       Valid Parenthesis: '(()())'
# Example 2 Input: $str = ')()())'
#           Output: 4
#       Valid Parenthesis: '()()' at positions 1-4.
# Example 3 Input: $str = '((()))()(((()'
#           Output: 8
#       Valid Parenthesis: '((()))()' at positions 0-7.
# Example 4 Input: $str = '))))((()('
#           Output: 2
#       Valid Parenthesis: '()' at positions 6-7.
# Example 5 Input: $str = '()(()'
#           Output: 2
#       Valid Parenthesis: '()' at positions 0-1 and 3-4.
#=============================================================================

use v5.42;


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

say longestParen($_) for @ARGV;

#=============================================================================
sub longestParenSub($str)
{
    # Since the ony characters are ( and ), if there are any balanced
    # sets at all, at some point there must be a (). Replace those with
    # something else (I'm using xx). Then keep replacing matching pairs
    # of parenthese as long as we have (xxxxxx) patterns.
    while ( $str =~ s/\((x*)\)/x$1x/g ) { }

    # Extract the strings of x, map to length, and find the longest one.
    use List::Util qw/max/;
    return ( max map { length($_) } $str =~ m/x+/g ) // 0;
}
sub longestParen($str)
{
    # Leading ) and trailing ( can never pair up, so a small
    # optimization is to trim those off before we start.
    $str =~ s/^\)+//;
    $str =~ s/\($//;

    # Stack up when we hit a (, pop off when we find a ).
    my @stack = ( -1 );
    my $longest = my $streak =  0;
    for my ($i, $p) ( indexed split(//, $str) )
    {
        if ( $p eq '(' )
        {
            push @stack, $i;    # Note, pushing index
        }
        else {
            pop @stack;
            if ( @stack )
            {
                my $len = $i - $stack[-1];
                $logger->debug(") i=$i len=$len stack=(@stack)");
                $longest = $len if $len > $longest;
            }
        }
        $logger->debug("$p i=$i, longest=$longest, stack=(@stack)");
    }

    return $longest;
}

sub runTest
{
    use Test2::V0;

    is( longestParen('(()())'       ),  6, "Example 1");
    is( longestParen(')()())'       ),  4, "Example 2");
    is( longestParen('((()))()(((()'),  8, "Example 3");
    is( longestParen('))))((()('    ),  2, "Example 4");
    is( longestParen('()(()'        ),  2, "Example 5");
    is( longestParen(')))))'        ),  0, "None )");
    is( longestParen('((((('        ),  0, "None (");
    is( longestParen('))((('        ),  0, "None )(");
    is( longestParen('(((((())))))' ), 12, "All");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $str = join('', map { int(rand(2)) % 2 ? '(' : ')' } 1..100);
    $logger->debug($str);
    cmpthese($repeat, {
            stack => sub { longestParen($str) },
            subst => sub { longestParenSub($str) },
        });
}

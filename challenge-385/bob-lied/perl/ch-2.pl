#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 385 Task 2  Outermost Parentheses
#=============================================================================
# You are given a valid parentheses string.  Write a script to return the
# string after removing the outermost parentheses of every primitive string
# in the primitive decomposition of the given string.
# Example 1 Input: $str = "()()()"
#           Output: ""
#       Primitive Decomposition: "()" + "()" + "()"
# Example 2 Input: $str = "(((())))"
#           Output: "((()))"
#       Primitive Decomposition: "(((())))"
# Example 3 Input: $str = "(()())(())"
#           Output: "()()()"
#       Primitive Decomposition: "(()())" + "(())"
# Example 4 Input: $str = "()((()))()"
#           Output: "(())"
#       Primitive Decomposition: "()" + "((()))" + "()"
# Example 5 Input: $str = "(()(()))(()())"
#           Output: "()(())()()"
#       Primitive Decomposition: "(()(()))" + "(()())"
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

say task($_), "\n", taskRE($_) for @ARGV;

#=============================================================================
sub task($str)
{
    use Text::Balanced qw/extract_bracketed/;
    my $output = '';

    while ( my $group = extract_bracketed($str, '()') )
    {
        $output .= substr($group, 1, length($group)-2);
    }
    return $output;
}

sub taskRE($str)
{
    use Regexp::Common qw/balanced/; use feature "multidimensional";
    my $output = '';

    my $rx = $RE{balanced}{-parens=>'()'}{-keep};
    while ( $str =~ m/$rx/g )
    {
        $output .= substr($1, 1, length($1)-2);
    }
    return $output;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(        "()()()"),           "", "Example 1");
    is( task(      "(((())))"),     "((()))", "Example 2");
    is( task(    "(()())(())"),     "()()()", "Example 3");
    is( task(    "()((()))()"),       "(())", "Example 4");
    is( task("(()(()))(()())"), "()(())()()", "Example 5");

    is( taskRE(        "()()()"),           "", "Example 1");
    is( taskRE(      "(((())))"),     "((()))", "Example 2");
    is( taskRE(    "(()())(())"),     "()()()", "Example 3");
    is( taskRE(    "()((()))()"),       "(())", "Example 4");
    is( taskRE("(()(()))(()())"), "()(())()()", "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $str = "(()(()))(()())" x 10;
    cmpthese($repeat, {
            balanced => sub { taskRE($str) },
            regex    => sub { taskRE($str) },
        });
}

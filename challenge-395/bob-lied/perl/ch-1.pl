#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 395 Task 1  Complex Number
#=============================================================================
# You are given two complex numbers as string.  Write a script to return the
# multiplication of the given complex numbers.
# Using the formula: (a + bi) x (c + di) = (ac - bd) + (ad + bc)i
# Example 1 Input: $num1 = "1+1i", $num2 = "1+1i"
#           Output: "0+2i"
# Example 2 Input: $num1 = "1+(-1)i", $num2 = "1+(-1)i"
#           Output: "0+(-2)i"
# Example 3 Input: $num1 = "0+3i", $num2 = "0+4i"
#           Output: "-12+0i"
# Example 4 Input: $num1 = "3+4i", $num2 = "3+(-4)i"
#           Output: "25+0i"
# Example 5 Input: $num1 = "50+(-20)i", $num2 = "-10+30i"
#           Output: "100+1700i"
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
sub task($num1, $num2)
{
    # Put real and imaginary parts in arrays
    my (@a, @b);
    {   use Regexp::Common;
        @a = $num1 =~ m/($RE{num}{real})/g;
        @b = $num2 =~ m/($RE{num}{real})/g;
    }

    use Math::Complex;
    my $z = cplx(@a) * cplx(@b);

    # Or direct manipulation of parts
    # my $real = $a[0] * $b[0] - $a[1] * $b[1];
    # my $imag = $a[0] * $b[1] + $a[1] * $b[0];

    # Extra step for required formatting with parentheses and showing 0
    my ($real, $imag) = ( $z->Re(), $z->Im() );
    $imag = "($imag)" if $imag < 0;
    return "$real+${imag}i";
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(     "1+1i",    "1+1i"),      "0+2i", "Example 1");
    is( task(  "1+(-1)i", "1+(-1)i"),   "0+(-2)i", "Example 2");
    is( task(     "0+3i",    "0+4i"),    "-12+0i", "Example 3");
    is( task(     "3+4i", "3+(-4)i"),     "25+0i", "Example 4");
    is( task("50+(-20)i", "-10+30i"), "100+1700i", "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}


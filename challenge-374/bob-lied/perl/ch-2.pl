#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 374 Task 2  Largest Same-Digits Number
#=============================================================================
# You are given a string containing 0-9 digits only.  Write a script to
# return the largest number with all digits the same in the given string.
# Example 1 Input: $str = "6777133339" Output: 3333
# Example 2 Input: $str = "1200034"    Output: 4
# Example 3 Input: $str = "44221155"   Output: 55
# Example 4 Input: $str = "88888"      Output: 88888
# Example 5 Input: $str = "11122233"   Output: 222
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

my @solution = (
    { func => \&lsdn_RE,   desc => "regex" },
    { func => \&lsdn_LIST, desc => "list" },
    { func => \&lsdn_STR,  desc => "substring" },
);

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

for my $s ( @solution )
{
    say "$s->{desc}: ", $s->{func}->($_) for @ARGV;
}

#=============================================================================
#
# First solution: Extract repeating strings with a regular expression
sub lsdn_RE($str)
{
    use List::Util qw/max/;
    return max ($str =~ m/((\d)\2*)/g);
}

#=============================================================================
#
# Second solution: Scan left to right as array, look at leading span of repeats
sub lsdn_LIST($str)
{
    my @n = split(//, $str);
    my $biggest = $n[0];

    while ( defined(my $digit = shift(@n)) )
    {
        my $val = $digit;
        $val .= shift(@n) while ( @n && $n[0] eq $digit );

        $biggest = $val if $val > $biggest;
    }
    return $biggest;
}

#=============================================================================
#
# Third solution: Similar to 2, but using substr instead of array manipulation
sub lsdn_STR($str)
{
    my $biggest = substr($str,0,1);
    
    my $beg = 0;
    while ( $beg < length($str) )
    {
        my $digit = substr($str, $beg, 1);
        my $width = 1;
        ++$width while ( substr($str, $beg+$width, 1) eq $digit );

        my $val = 0+substr($str, $beg, $width);
        $biggest = $val if $val > $biggest;

        $beg += $width;
    }
    return $biggest;
}

#=============================================================================
sub runTest
{
    use Test2::V0;

    my @test = (
        { input => "6777133339", expect =>  3333, desc => "Example 1" },
        { input => "1200034"   , expect =>     4, desc => "Example 2" },
        { input => "44221155"  , expect =>    55, desc => "Example 3" },
        { input => "88888"     , expect => 88888, desc => "Example 4" },
        { input => "11122233"  , expect =>   222, desc => "Example 5" },
    );

    for my $s ( @solution )
    {
        for my $tc ( @test )
        {
            is( $s->{func}->($tc->{input}),  $tc->{expect},  "$s->{desc}, $tc->{desc}");
        }
    }

    done_testing;
}

#=============================================================================
sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    use List::Util qw/shuffle/;
    my $input = join("", shuffle ( ( 0 .. 9 ) x 50 ) );

    cmpthese($repeat, {
            regex  => sub { lsdn_RE($input) },
            list   => sub { lsdn_LIST($input) },
            substr => sub { lsdn_STR($input) },
        });
}

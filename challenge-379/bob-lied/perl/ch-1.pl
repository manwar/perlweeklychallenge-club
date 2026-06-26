#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 379 Task 1  Reverse String
#=============================================================================
# You are given a string.  Write a script to reverse the given string without
# using standard reverse function.
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

say rev($_) for @ARGV;

#=============================================================================
sub rev($str)
{
    my $end = length($str);
    my $beg = -1;
    while ( --$end > ++$beg )
    {
        my $first = substr($str, $beg, 1);
        substr($str, $beg, 1) = substr($str, $end, 1);
        substr($str, $end, 1) = $first;
    }
    return $str;
}

sub rev2($str)
{
    my @str = split(//, $str);
    my ($beg, $end) = ( -1, scalar(@str) );
    while ( --$end > ++$beg )
    {
        @str[$beg, $end] = @str[$end, $beg];
    }
    return join("", @str);
}

sub rev3($str)
{
    my $rev = "";
    my $end = length($str);
    while ( --$end >= 0 )
    {
        $rev .= substr($str, $end, 1)
    }
    return $rev;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( rev(""), "", "Example 1");
    is( rev("reverse the given string"), "gnirts nevig eht esrever", "Example 2");
    is( rev("Perl is Awesome"), "emosewA si lreP", "Example 3");
    is( rev("v1.0.0-Beta!"), "!ateB-0.0.1v", "Example 4");
    is( rev("racecar"), "racecar", "Example 5");

    is( rev2(""), "", "Example 1");
    is( rev2("reverse the given string"), "gnirts nevig eht esrever", "Example 2");
    is( rev2("Perl is Awesome"), "emosewA si lreP", "Example 3");
    is( rev2("v1.0.0-Beta!"), "!ateB-0.0.1v", "Example 4");
    is( rev2("racecar"), "racecar", "Example 5");

    is( rev3(""), "", "Example 1");
    is( rev3("reverse the given string"), "gnirts nevig eht esrever", "Example 2");
    is( rev3("Perl is Awesome"), "emosewA si lreP", "Example 3");
    is( rev3("v1.0.0-Beta!"), "!ateB-0.0.1v", "Example 4");
    is( rev3("racecar"), "racecar", "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam elit neque, venenatis ut dolor consectetur, iaculis venenatis arcu. In interdum mauris eget neque venenatis dapibus. Sed finibus varius sapien quis malesuada. Fusce libero augue, vulputate sit amet faucibus at, feugiat at lectus. Maecenas vehicula sem metus. Nullam lobortis massa et est vulputate facilisis. In tempus arcu metus, vitae aliquam nibh sodales ac. Sed vitae erat nec nisl laoreet fringilla. Aliquam et lobortis purus. Ut a tristique nisi, nec molestie arcu. Duis mattis ultrices nisl eget consectetur. Donec ac lorem non augue bibendum tincidunt interdum quis velit. In gravida metus vitae.";

    cmpthese($repeat, {
            string => sub { rev($lorem) },
            array  => sub { rev2($lorem) },
            build  => sub { rev3($lorem) },
        });
}


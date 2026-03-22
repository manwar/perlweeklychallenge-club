#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 365 Task 2  Valid Token Counter
#=============================================================================
# You are given a sentence. Write a script to split the given sentence into
# space-separated tokens and count how many are valid words. A token is valid
# if it contains no digits, has at most one hyphen surrounded by lowercase
# letters, and at most one punctuation mark (!.,) appearing only at the end.
# Example 1 Input: $str = "cat and dog"
#			Output: 3
# Example 2 Input: $str = "a-b c! d,e"
#			Output: 2
# Example 3 Input: $str = "hello-world! this is fun"
#			Output: 4
# Example 4 Input: $str = "ab- cd-ef gh- ij!"
#			Output: 2
# Example 5 Input: $str = "wow! a-b-c nice."
#			Output: 2
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

say vtc3("@ARGV");

#=============================================================================
# This version explicitly checks for violations
sub vtc($str)
{
    my $valid = 0;
    for my $token ( split(" ", $str) )
    {
        # No digits, no punctuation except !,.-
        next if ( $token =~ m/(?[ [:digit:] + [:punct:] - [!.,-] ])/ );
        $logger->debug("$token passes digit test");

        # If !,. exist, must be at end, so no character following
        next if ( $token =~ m/[!.,]./ );
        $logger->debug("$token passes punctuation test");

        # Maximum of 1 dash
        next if ($token =~ tr/-/-/) > 1;

        # Both sides of a dash must be a lowercase letter.
        # Using look-around handles start and end of string.
        next if $token =~ m/(?<![a-z])-|-(?![a-z])/;
        $logger->debug("$token passes  dash test");

        $valid++;
    }
    return $valid;
}

# This version allows valid strings, doesn't try to identify violation,
# but assumes only lower-case characters.
sub vtc2($str)
{
    my $valid = 0;
    for my $word ( split(" ", $str) )
    {
        if ( $word =~ m/^ (?: [[:lower:]]+ (?: - [[:lower:]]+)? )? [!,.]?$/x )
        {
            $valid++;
        }
    }
    return $valid;
}

# Allow uppercase
sub vtc3($str)
{
    my $valid = 0;
    for my $word ( split(" ", $str) )
    {
        if ( $word =~ m/^ [[:alpha:]]* ([[:lower:]]-[[:lower:]])? [[:alpha:]]* [!.,]? $/x )
        {
            $valid++;
        }
    }
    return $valid;
}

sub runTest
{
    use Test2::V0;

    my @case = (
        { str => "cat and dog",              expect => 3, desc => "Example 1" },
        { str => "a-b c! d,e",               expect => 2, desc => "Example 2" },
        { str => "hello-world! this is fun", expect => 4, desc => "Example 3" },
        { str => "ab- cd-ef gh- ij!",        expect => 2, desc => "Example 4" },
        { str => "wow! a-b-c nice.",         expect => 2, desc => "Example 5" },
        { str => "m",     expect => 1, desc => "Single valid character" },
        { str => "!",     expect => 1, desc => "Single valid punctuation character" },
        { str => "7",     expect => 0, desc => "Single invalid digit" },
        { str => "g , 9", expect => 2, desc => "Single characters" },
        { str => "",      expect => 0, desc => "Empty string" },
        { str => "-xyz",  expect => 0, desc => "Leading dash"  },
    );

    my @version = ( { name => "check", func => \&vtc },
                    { name => "lower", func => \&vtc2 },
                    { name => "upper", func => \&vtc3 },
                );

    for my $v  (@version)
    {
        for my $c ( @case )
        {
            is( $v->{func}($c->{str}), $c->{expect}, "$v->{name} $c->{desc}" );
        }
    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $lorem = lc("Lorem ipsum dolor sit amet, consectetur adipiscing elit. E  tiam elit neque, venenatis ut dolor consectetur, iaculis venenatis arcu. In in  terdum mauris eget neque venenatis dapibus. Sed finibus varius sapien quis mal  esuada. Fusce libero augue, vulputate sit amet faucibus at, feugiat at lectus.   Maecenas vehicula sem metus. Nullam lobortis massa et est vulputate facilisis  . In tempus arcu metus, vitae aliquam nibh sodales ac. Sed vitae erat nec nisl   laoreet fringilla. Aliquam et lobortis purus. Ut a tristique nisi, nec molest  ie arcu. Duis mattis ultrices nisl eget consectetur. Donec ac lorem non augue   bibendum tincidunt interdum quis velit. In gravida metus vitae.");

    cmpthese($repeat, {
            check  => sub { vtc($lorem) },
            lower  => sub { vtc2($lorem) },
            upper  => sub { vtc3($lorem) },
        });
}

#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 313 Task 1 Broken Keys
#=============================================================================
# You have a broken keyboard which sometimes type a character more than once.
# You are given a string and actual typed string. Write a script to find out
# if the actual typed string is meant for the given string.
# Example 1 Input: $name = "perl", $typed = "perrrl"
#           Output: true
# Example 2 Input: $name = "raku", $typed = "rrakuuuu"
#           Output: true
# Example 3 Input: $name = "python", $typed = "perl"
#           Output: false
# Example 4 Input: $name = "coffeescript", $typed = "cofffeescccript"
#           Output: true
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

#say broken($ARGV[0], $ARGV[1]) ? "true" : "false";
say broke2($ARGV[0], $ARGV[1]) ? "true" : "false";

#=============================================================================
sub broken($name, $typed)
{
    my @c = split(//, $name);
    my $prev = my $c = shift @c;
    my $cnt = 1;
    my $re = "";
    while ( defined($c = shift @c) )
    {
        if ( $c eq "$prev" )
        {
            $cnt++;
        }
        else
        {
            $re .= "${prev}{$cnt,}";
            $cnt = 1;
        }
        $prev = $c;
    }
    $re .= "${prev}{$cnt,}";
    $logger->debug("name=$name typed=$typed RE=/$re/");
    return $typed =~ m/^$re$/;
}

sub broke2($name, $typed)
{
    my @name  = split(//, $name);
    my @typed = split(//, $typed);
    while ( defined(my $c = shift @name) )
    {
        my $t = shift @typed;
        return false if $t ne $c;
        # Consume all occurrences of $c in both strings
        $c = shift @name  while @name  && $name[0]  eq $c;
        $t = shift @typed while @typed && $typed[0] eq $c;
    }
    return true if @typed == 0;
}

sub runTest
{
    use Test2::V0;

    is( broken("perl", "perrl"),                    true, "Example 1");
    is( broken("raku", "rrakuuuu"),                 true, "Example 2");
    is( broken("python", "perl"),                  false, "Example 3");
    is( broken("coffeescript", "cofffeescccript"),  true, "Example 4");
    is( broken("perrrl", "perl"),                  false, "Missing from typed");

    is( broke2("perl", "perrl"),                    true, "Example 1");
    is( broke2("raku", "rrakuuuu"),                 true, "Example 2");
    is( broke2("python", "perl"),                  false, "Example 3");
    is( broke2("coffeescript", "cofffeescccript"),  true, "Example 4");
    is( broke2("perrrl", "perl"),                  false, "Missing from typed");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            re   => sub { broken("coffeescript", "cofffeescccript") },
            loop => sub { broke2("coffeescript", "cofffeescccript") },
        });
}

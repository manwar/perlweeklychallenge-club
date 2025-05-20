#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 322 Task 1 String Format
#=============================================================================
# You are given a string and a positive integer.  Write a script to format
# the string, removing any dashes, in groups of size given by the integer.
# The first group can be smaller than the integer but should have at least
# one character. Groups should be separated by dashes.
# Example 1 Input: $str = "ABC-D-E-F", $i = 3
#           Output: "ABC-DEF"
# Example 2 Input: $str = "A-BC-D-E", $i = 2
#           Output: "A-BC-DE"
# Example 3 Input: $str = "-A-B-CD-E", $i = 4
#           Output: "A-BCDE"
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

say strFmtUnpack(@ARGV);

#=============================================================================
sub strFmtRE($str, $i)
{
    $str = reverse $str =~ s/-+//gr;
    $str = reverse $str =~ s/.{$i}/$&-/gr;
    return $str =~ s/^-//r;
}

sub strFmtSubstr($str, $i)
{
    $str = reverse $str =~ s/-+//gr;
    my $d = int( (length($str) - 0.5) / $i);

    for my $p ( map { $_ * $i } reverse 1 .. $d )
    {
        substr($str, $p, 0, '-');
        $logger->debug("i=$i p=$p str=$str");
    }
    return reverse $str;
}

sub strFmtUnpack($str, $i)
{
    return scalar reverse join("-", unpack("(A$i)*", reverse $str =~ s/-//gr));
}

sub runTest
{
    use Test2::V0;

    is( strFmtRE("ABC-D-E-F", 3), "ABC-DEF", "Example 1");
    is( strFmtRE("A-BC-D-E" , 2), "A-BC-DE", "Example 2");
    is( strFmtRE("-A-B-CD-E", 4), "A-BCDE",  "Example 3");

    is( strFmtSubstr("ABC-D-E-F", 3), "ABC-DEF", "Example 1");
    is( strFmtSubstr("A-BC-D-E" , 2), "A-BC-DE", "Example 2");
    is( strFmtSubstr("-A-B-CD-E", 4), "A-BCDE",  "Example 3");

    is( strFmtUnpack("ABC-D-E-F", 3), "ABC-DEF", "Example 1");
    is( strFmtUnpack("A-BC-D-E" , 2), "A-BC-DE", "Example 2");
    is( strFmtUnpack("-A-B-CD-E", 4), "A-BCDE",  "Example 3");

    done_testing;
}

# $ perl ch-1.pl -b 200000
#            Rate substr  regex unpack
# substr  54054/s     --   -54%   -81%
# regex  117647/s   118%     --   -58%
# unpack 281690/s   421%   139%     --
sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $str = "xyzzy" x 200;
    my $i   = 23;

    cmpthese($repeat, {
            regex  => sub { strFmtRE($str, $i) },
            substr => sub { strFmtSubstr($str, $i) },
            unpack => sub { strFmtUnpack($str, $i) },
        });
}

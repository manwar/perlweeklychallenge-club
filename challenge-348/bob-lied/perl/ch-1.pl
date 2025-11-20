
#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 348 Task 1  String Alike
#=============================================================================
# You are given a string of even length.  Write a script to find out whether
# the given string can be split into two halves of equal lengths, each with
# the same non-zero number of vowels.
# Example 1 Input: $str = "textbook"
#           Output: false
#   1st half: "text" (1 vowel)  2nd half: "book" (2 vowels)
# Example 2 Input: $str = "book"
#           Output: true
#   1st half: "bo" (1 vowel)    2nd half: "ok" (1 vowel)
# Example 3 Input: $str = "AbCdEfGh"
#           Output: true
#   1st half: "AbCd" (1 vowel)  2nd half: "EfGh" (1 vowel)
# Example 4 Input: $str = "rhythmmyth"
#           Output: false
#   1st half: "rhyth" (0 vowel) 2nd half: "mmyth" (0 vowel)
# Example 5 Input: $str = "UmpireeAudio"
#           Output: false
#   1st half: "Umpire" (3 vowels) 2nd half: "eAudio" (5 vowels)
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

say strAlike($_) for @ARGV;

#=============================================================================

sub strAlike($str)
{
    $str = lc($str);
    my $mid = length($str) / 2;
    my @count = map { $_ =~ tr/aeiou// }
                        substr($str, 0, $mid), substr($str, $mid);
    return $count[0] == $count[1] && $count[0] > 0;
}


sub runTest
{
    use Test2::V0;

    is( strAlike(    "textbook"), false , "Example 1");
    is( strAlike(        "book"),  true , "Example 2");
    is( strAlike(     "AbCEfGh"),  true , "Example 3");
    is( strAlike(  "rhythmmyth"), false , "Example 4");
    is( strAlike("UmpireeAudio"), false , "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}


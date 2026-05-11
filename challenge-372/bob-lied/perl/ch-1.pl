#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 372 Task 1  Rearrange Spaces
#=============================================================================
# You are given a string text of words that are placed among number of spaces.
# Write a script to rearrange the spaces so that there is an equal number of
# spaces between every pair of adjacent words and that number is maximised.
# If you can’t distribute, place the extra spaces at the end.
# Finally return the string.
# Example 1 Input: $str = "  challenge  "
#           Output: "challenge    "
# Example 2 Input: $str = "coding  is  fun"
#           Output: "coding  is  fun"
# Example 3 Input: $str = "a b c  d"
#           Output: "a b c d "
# Example 4 Input: $str = "  team      pwc  "
#           Output: "team          pwc"
# Example 5 Input: $str = "   the  weekly  challenge  "
#           Output: "the    weekly    challenge "
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

for my $func ( \&rearrange, \&r2 )
{
    say $func->($_) for @ARGV;
}

#=============================================================================
sub rearrange($str)
{
    my $spaceCount = $str =~ tr/ //;

    my @word = split(" ", trim($str));

    my $gapSize = ( $#word ? int($spaceCount / $#word) : $spaceCount );
    my $gap = " " x $gapSize;

    return substr(join("", map { "$_$gap" } @word), 0, length($str));
}

sub r2($str)
{
    use List::MoreUtils qw/pairwise/;

    (my $sp = $str) =~ tr/ //dc;    # String of all spaces from str

    my @word = split(" ", trim($str));

    my $gapSize = ( $#word ? int(length($sp) / $#word) : length($sp) );

    my @gap = unpack("(a$gapSize)*", $sp);

    return join "", pairwise { ($a // '') . ($b // "") } @word, @gap;

}

sub runTest
{
    use Test2::V0;

    is( rearrange("  challenge  "),     "challenge    ",     "Example 1");
    is( rearrange("coding  is  fun"),   "coding  is  fun",   "Example 2");
    is( rearrange("a b c  d"),          "a b c d ",          "Example 3");
    is( rearrange("  team      pwc  "), "team          pwc", "Example 4");
    is( rearrange("   the  weekly  challenge  "), "the    weekly    challenge ", "Example 5");
    is( rearrange("nospace"), "nospace", "No spaces");

    is( r2("  challenge  "),     "challenge    ",     "Example 1");
    is( r2("coding  is  fun"),   "coding  is  fun",   "Example 2");
    is( r2("a b c  d"),          "a b c d ",          "Example 3");
    is( r2("  team      pwc  "), "team          pwc", "Example 4");
    is( r2("   the  weekly  challenge  "), "the    weekly    challenge ", "Example 5");
    is( r2("nospace"), "nospace", "No spaces");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $str = q( Example 1 Input: $str =   challenge   #           Output: challenge     # Example 2 Input: $str = coding  is  fun #           Output: coding  is  fun # Example 3 Input: $str = a b c  d #           Output: a b c d  # Example 4 Input: $str =   team      pwc   #           Output: team          pwc # Example 5 Input: $str =    the  weekly  challenge   #           Output: the    weekly    challenge );
    cmpthese($repeat, {
            map      => sub { rearrange($str) },
            pairwise => sub { r2($str) },
        });
}

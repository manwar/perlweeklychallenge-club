#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 363 Task 1  String Lie Detector
#=============================================================================
# You are given a string.  Write a script that parses a self-referential
# string and determines whether its claims about itself are true. The string
# will make statements about its own composition, specifically the number of
# vowels and consonants it contains.
# Example 1 Input: $str = "aa — two vowels and zero consonants"
#			Output: true
# Example 2 Input: $str = "iv — one vowel and one consonant"
#			Output: true
# Example 3 Input: $str = "hello - three vowels and two consonants"
#			Output: false
# Example 4 Input: $str = "aeiou — five vowels and zero consonants"
#			Output: true
# Example 5 Input: $str = "aei — three vowels and zero consonants"
#			Output: true
#=============================================================================

use v5.42;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

say detect("@ARGV") ? "true" : "false";

#=============================================================================
sub detect($str)
{
    state %numeral = ( one => 1, two => 2,   three => 3, four => 4, five => 5,
                       six => 6, seven => 7, eight => 8, nine => 9, zero => 0  );
    my ($word, $vowel, $consonant) = (split(" ", $str))[0, 2, 5];
    $vowel = $numeral{$vowel};
    $consonant = $numeral{$consonant};

    my $vcount = ( $word =~ tr/aeiou/aeiou/ );

    return $vcount == $vowel && ($vowel + $consonant == length($word));
}

sub runTest
{
    use Test2::V0;

    is( detect("aa — two vowels and zero consonants"    ),  true, "Example 1");
    is( detect("iv — one vowel and one consonant"       ),  true, "Example 2");
    is( detect("hello - three vowels and two consonants"), false, "Example 3");
    is( detect("aeiou — five vowels and zero consonants"),  true, "Example 4");
    is( detect("aei — three vowels and zero consonants" ),  true, "Example 5");
    is( detect("aei — three vowels and nine consonants" ), false, "Too many consonants");
    is( detect("abcdef — two vowels and one consonants" ), false, "Not enough consonants");
    is( detect("aei — four vowels and zero consonants" ), false, "Too many vowels");
    is( detect("abcdef — one vowels and four consonants" ), false, "Not enough vowels");

    done_testing;
}

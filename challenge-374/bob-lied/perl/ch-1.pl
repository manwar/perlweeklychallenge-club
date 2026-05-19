#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 374 Task 1  Count Vowel
#=============================================================================
# You are given a string.  Write a script to return all possible vowel
# substrings in the given string. A vowel substring is a substring that
# only consists of vowels and has all five vowels present in it.
# Example 1 Input: $str = "aeiou"
#           Output: ("aeiou")
# Example 2 Input: $str = "aaeeeiioouu"
#           Output: ("aaeeeiioou", "aeeeiioou", "aeeeiioouu")
# Example 3 Input: $str = "aeiouuaxaeiou"
#           Output: ("aeiou", "aeiou", "eiouua")
# Example 4 Input: $str = "uaeiou"
#           Output: ("aeiou", "uaeio")
# Example 5 Input: $str = "aeioaeioa"
#           Output: ()
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
use enum qw(BITMASK:V_ A E I O U);
my $ALL_VOWELS = V_A|V_E|V_I|V_O|V_U;
my %V = (a => V_A, e => V_E, i => V_I, o => V_O, u => V_U );
#=============================================================================

exit(!runTest()) if $DoTest;

say '(', join(",", countVowel($_)->@*), ')' for @ARGV;

#=============================================================================
sub countVowel($str)
{
    my @answer;

    my @c = split(//, lc($str));

    START: while ( defined(my $first = shift @c) )
    {
        next unless isVowel($first);

        my $span = $first;
        my $have = $V{$first};

        my $i = 0;
        while ( $i <= $#c && isVowel(my $next = $c[$i++]) )
        {
            $span .= $next;
            $have |= $V{$next};
            if ( $have == $ALL_VOWELS )
            {
                push @answer, $span;
            }
        }
    }

    return \@answer;
}

sub isVowel($c) { return index("aeiou", $c) >= 0 }

sub runTest
{
    use Test2::V0;

    sub order($v) { [ sort { $a cmp $b } $v->@* ] }

    is( order(countVowel("aeiou")),
        order(["aeiou"                     ]), "Example 1");
    is( order(countVowel("aaeeeiioouu")),  
        order(["aaeeeiioouu", "aaeeeiioou", "aeeeiioou", "aeeeiioouu"]), "Example 2");
    is( order(countVowel("aeiouuaxaeiou")),
        order(["aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua"]), "Example 3");
    is( order(countVowel("uaeiou")),
        order(["aeiou", "uaeio", "uaeiou"  ]), "Example 4");
    is( order(countVowel("aeioaeioa")),
        order([                            ]), "Example 5");

    done_testing;
}

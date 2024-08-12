#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 282 Task 2 Changing Keys
#=============================================================================
# You are given an alphabetic string, $str, as typed by user.
# Write a script to find the number of times user had to change the key to
# type the given string. Changing key is defined as using a key different
# from the last used key. The shift and caps lock keys won’t be counted.
# Example 1 Input: $str = 'pPeERrLl'
#           Output: 3
#   p -> P : 0 key change
#   P -> e : 1 key change
#   e -> E : 0 key change
#   E -> R : 1 key change
#   R -> r : 0 key change
#   r -> L : 1 key change
#   L -> l : 0 key change
# Example 2 Input: $str = 'rRr'
#           Output: 0
# Example 3 Input: $str = 'GoO'
#           Output: 1
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

# My keyboard on a MacBook
my %Keyboard = (
    US => { LC => q(1234567890-=qwertyuiop[]\asdfghjkl;'zxcvbnm,./ ),
            UC => q(!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:"ZXCVBNM<>? ),
        },
    ES => { LC => q(1234567890'¿qwertyuiop´+}asdfghjklñ{zxcvbnm,.- ),
            UC => q(!"#$%&/()=?¡QWERTYUIOP¨*]ASDFGHJKLÑ[ZXCVBNM;:_ ),
        }
);
my %KEY;
foreach ( 0 .. length($Keyboard{US}{LC})-1 )
{
    $KEY{ substr($Keyboard{US}{LC}, $_, 1) } = $KEY{substr($Keyboard{US}{UC}, $_, 1)} = $_;
}

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say change($_) for @ARGV;

sub change($str)
{
    my $count = 0;
    my @char = split(//, lc $str);
    my $first = shift @char;
    while ( defined(my $second = shift @char) )
    {
        $count++ if $KEY{$first} != $KEY{$second};
        $first = $second;
    }
    return $count;
}

sub runTest
{
    use Test2::V0;

    is( change('pPeErLl'), 3, "Example 1");
    is( change('rRr'),     0, "Example 2");
    is( change('GoO'),     1, "Example 3");
    is( change('(90)>.3'), 3, "Punctuation and numbers");
    is( change($Keyboard{US}{LC}),      46, "All the things");
    is( change($Keyboard{US}{UC}),      46, "All the things, but shifted");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

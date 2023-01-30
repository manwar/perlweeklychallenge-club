#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 200 Task 2 Seven Segment 200
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# A seven segment display is an electronic component, usually used to
# display digits. The segments are labeled 'a' through 'g' as shown:
#   
#    --   <- a
#  f|  |b
#    --   <- g
#  e|  |c
#    --   <- d
#
# The encoding of each digit can be represented compactly as a truth table:
# 
# my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
# 
# For example, $truth[1] = ‘bc’. The digit 1 would have segments ‘b’ and ‘c’
# enabled.
# 
# Write a program that accepts any decimal number and draws that number
# as # a horizontal sequence of ASCII seven segment displays, similar to
# the # following:
#
# -------  -------  -------
#       |  |     |  |     |
#       |  |     |  |     |
# -------
# |        |     |  |     |
# |        |     |  |     |
# -------  -------  -------
#
# To qualify as a seven segment display, each segment must be drawn (or not
# drawn) according to your @truth table.
# The number "200" was of course chosen to celebrate our 200th week!
#=============================================================================

use v5.36;

# Which segments are on for each digit?
             #    0    1   2     3    4     5     6     7     8      9
my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;

# 7x7 as one 49-character string, a few different styles
# aaaaaaa     aaaaa          aaaaa
# f     f    f     b        ff   bb  Bold version
# f     b    f     b        ff   bb
# ggggggg     ggggg          ggggg
# e     c    e     c        ee   cc
# e     c    e     c        ee   cc
# ddddddd     ddddd          ddddd
#my $Digit = 'aaaaaaaf     bf     bggggggge     ce     cddddddd'; # Match example
 my $Digit = ' aaaaa f     bf     b ggggg e     ce     c ddddd '; # Rounded corners
#my $Digit = 'aaaaaaaff   bbff   bbgggggggee   ccee   ccddddddd'; # Bold

# Display characteristics
 my %Char;
#$Char{$_} = '-' for qw(a d g); $Char{$_} = '|' for qw(b c e f);
#$Char{$_} = '=' for qw(a d g); $Char{$_} = '|' for qw(b c e f);
#$Char{$_} = '#' for qw(a b c d e f g);
#$Char{$_} = 'o' for qw(a b c d e f g);

# Use Unicode horizontal and vertical bars
binmode(STDOUT, "encoding(UTF-8)"); # No "wide character" warning
#$Char{$_} = "\x{2500}" for qw(a d g); $Char{$_} = "\x{2502}" for qw(b c e f);
 $Char{$_} = "\x{2501}" for qw(a d g); $Char{$_} = "\x{2503}" for qw(b c e f);
# $Char{$_} = "\x{2550}" for qw(a d g); $Char{$_} = "\x{2551}" for qw(b c e f);

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

displayAsSegment($_) for @ARGV;

sub displayAsSegment($str)
{
    # Make a 49-character segment string for each digit
    my @seg = map { asSegment($_) } split '', $str;

    for my $row ( 0 .. 6 )
    {
        # Make a row by taking a 7-char substring of each segment
        # Top row:    0 ..  6     0 ..  6     0 ..  6
        #       2:    7    13     7 .. 13     7 .. 13
        #   ...
        #       7:   42 .. 48    42 .. 48    42 .. 48
        say join("  ", map { substr($seg[$_], $row*7, 7) } 0 .. $#seg);
    }
}

sub asSegment($digit)
{
    my $seven = $Digit;
    my $t = $truth[$digit];

    # Turn off segments not in the digit
    $seven =~ s/[^$t]/ /g;

    for my $on ( split '', $t )
    {
        $seven =~ s/$on/$Char{$on}/g;
    }
    return $seven;
}

sub runTest
{
    use Test2::V0;

            my $Digit = ' aaaaa f     bf     b ggggg e     ce     c ddddd ';
    is( asSegment("0"), ' ----- |     ||     |       |     ||     | ----- ', "asSegment 0");
    is( asSegment("1"), '             |      |             |      |       ', "asSegment 1");
    is( asSegment("2"), ' -----       |      | ----- |      |       ----- ', "asSegment 2");
    is( asSegment("3"), ' -----       |      | -----       |      | ----- ', "asSegment 3");
    is( asSegment("4"), '       |     ||     | -----       |      |       ', "asSegment 4");
    is( asSegment("5"), ' ----- |      |       -----       |      | ----- ', "asSegment 5");
    is( asSegment("6"), ' ----- |      |       ----- |     ||     | ----- ', "asSegment 6");
    is( asSegment("7"), ' -----       |      |             |      |       ', "asSegment 7");
    is( asSegment("8"), ' ----- |     ||     | ----- |     ||     | ----- ', "asSegment 8");
    is( asSegment("9"), ' ----- |     ||     | -----       |      |       ', "asSegment 9");

    done_testing;
}

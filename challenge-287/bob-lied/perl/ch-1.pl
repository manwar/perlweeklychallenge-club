#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 287 Task 1 Strong Password
#=============================================================================
# You are given a string, $str.
# Write a program to return the minimum number of steps required to make the
# given string very strong password. If it is already strong then return 0.
# Criteria:
# - It must have at least 6 characters.
# - It must contains at least one lowercase letter, at least one
#   upper case letter and at least one digit.
# - It shouldn't contain 3 repeating characters in a row.
# Following can be considered as one step:
# - Insert one character
# - Delete one character
# - Replace one character with another
#
# Example 1 Input: $str = "a"         Output: 5
# Example 2 Input: $str = "aB2"       Output: 3
# Example 3 Input: $str = "PaaSW0rd"  Output: 0
# Example 4 Input: $str = "Paaasw0rd" Output: 1
# Example 5 Input: $str = "aaaaa"     Output: 2
#=============================================================================

use v5.40;
use English;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

my $OpCount = 0;

use constant { C_LC => 1, C_UC => 2, C_DIG => 4, C_OTHER => 8 };

sub hasClass($s)
{
    return ( ($s =~ m/\p{Lower}/) && C_LC)
         | ( ($s =~ m/\p{Upper}/) && C_UC)
         | ( ($s =~ m/\p{Digit}/) && C_DIG);
}


my $LOWER = join("", ("a".."z"));
my $UPPER = join("", ("A".."Z"));
my $DIGIT = join("", ( 0 .. 9 ));

my @NeedClass;
$NeedClass[ 0     | 0    | 0    ] = "$DIGIT$UPPER$LOWER";
$NeedClass[ 0     | 0    | C_LC ] = "$DIGIT$UPPER";
$NeedClass[ 0     | C_UC | 0    ] = "$DIGIT$LOWER";
$NeedClass[ 0     | C_UC | C_LC ] = "$DIGIT";
$NeedClass[ C_DIG | 0    | 0    ] = "$UPPER$LOWER";
$NeedClass[ C_DIG | 0    | C_LC ] = "$UPPER";
$NeedClass[ C_DIG | C_UC | 0    ] = "$LOWER";
$NeedClass[ C_DIG | C_UC | C_LC ] = "$DIGIT$UPPER$LOWER";
sub need($charClass) { return $NeedClass[$charClass]  }

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say strongPassword($_) for @ARGV;

sub randFromExcl($from, $exclude)
{
    $from =~ s/[$exclude]//g if $exclude ne "";
    substr($from, int(rand(length($from))), 1);
}

sub rmvRepeat($s, $rplc = "")
{
    while ( $s =~ m/(.)\1\1/ )
    {
        my $char  = $1;
        my $notThis = substr($POSTMATCH, 0, 1);

        # Replace every 3rd occurrence of the char with a useful
        # substitue. Don't match the following character, which might
        # inadvertently create a new repeat.

        my $use = ( $rplc eq "" )
                ?  randFromExcl( need(hasClass($s)), "$char$notThis")
                : $rplc;

        $s =~ s/\Q$char$char$char/$char$char$use/;
        $OpCount++;
    }
    return $s;
}


sub strongPassword($str)
{
    $OpCount = 0;
    $str = rmvRepeat($str);

    while ( (my $have = hasClass($str)) != (C_UC|C_LC|C_DIG) )
    {
        $str .= randFromExcl( need($have), "");
        $OpCount++;
    }

    while ( length($str) < 6 )
    {
        $str .= randFromExcl( need(0), "");
        $OpCount++;
    }
    say $str if $Verbose;

    return $OpCount;
}

sub calcOp($str)
{
    my $s = length($str);
    my $r = () = $str =~ m/(.)\1\1/g; # Number of repeated triples
    my $n = 3 - ($str =~ m/\p{Lower}/)
              - ($str =~ m/\p{Upper}/)
              - ($str =~ m/\p{Digit}/);

    my $opCount = $r;
    if ( $r > 0 && $n > 0 )
    {
        # Some triplets can be used to swap in missing classes.
        if ( $r >= $n ) { $n = 0 }
        else            { $n -= $r }
    }

    if ( $n > 0 )
    {
        $s += $n; # Add missing classes, makes string longer
        $opCount += $n;
    }

    $opCount += (6-$s) if $s < 6; # Pad string if too short.
    return $opCount;
}


sub runTest
{
    use Test2::V0;

    is( hasClass("aA0"), (C_LC|C_UC|C_DIG), "hasClass ALL");
    is( hasClass( "A0"), (     C_UC|C_DIG), "hasClass no LC");
    is( hasClass( "a0"), (C_LC|     C_DIG), "hasClass no UC");
    is( hasClass( "aA"), (C_LC|C_UC      ), "hasClass no DIG");
    is( hasClass( "aa"), (C_LC           ), "hasClass LC");
    is( hasClass( "AA"), (     C_UC      ), "hasClass UC");
    is( hasClass( "35"), (          C_DIG), "hasClass DIG");
    

    is( rmvRepeat("",       "B"), "",       "rmvRepeat ''");
    is( rmvRepeat("A",      "B"), "A",      "rmvRepeat A");
    is( rmvRepeat("AA",     "B"), "AA",     "rmvRepeat AA");
    is( rmvRepeat("AAA",    "B"), "AAB",    "rmvRepeat AAA");
    is( rmvRepeat("AAAA",   "c"), "AAcA",   "rmvRepeat AAAA");
    is( rmvRepeat("AAAAA",  "1"), "AA1AA",  "rmvRepeat AAAAA");
    is( rmvRepeat("AAAAAA", "d"), "AAdAAd", "rmvRepeat AAAAAA");
    is( rmvRepeat(",,,,,,", "d"), ",,d,,d", "rmvRepeat ,,,,,,");
    like( rmvRepeat("A"x10), qr/AA[^A]AA[^A]AA[^A]A/,  "rmvRepeat Ax10 random");

    is( strongPassword("a"),         5, "Example 1");
    is( strongPassword("a02"),       3, "Example 2");
    is( strongPassword("PaaSW0rd"),  0, "Example 3");
    is( strongPassword("Paaasw0rd"), 1, "Example 4");
    is( strongPassword("aaaaa"),     2, "Example 5");

    is( calcOp("a"),         5, "Example 1 calcOp");
    is( calcOp("a02"),       3, "Example 2 calcOp");
    is( calcOp("PaaSW0rd"),  0, "Example 3 calcOp");
    is( calcOp("Paaasw0rd"), 1, "Example 4 calcOp");
    is( calcOp("aaaaa"),     2, "Example 5 calcOp");

    done_testing;
}

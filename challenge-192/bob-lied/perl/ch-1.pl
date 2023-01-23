#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 192 Task 1 Binary Flip
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a positive integer, $n.
# Write a script to find the binary flip.
#
# Example 1 Input: $n = 5 Output: 2
#   First find the binary equivalent of the given integer, 101.
#   Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.
#   So Binary 010 => Decimal 2.
# Example 2 Input: $n = 4 Output: 3
#   Decimal 4 = Binary 100 Flip 0 -> 1 and 1 -> 0, we get 011.
#   Binary 011 = Decimal 3
# Example 3 Input: $n = 6 Output: 1
#   Decimal 6 = Binary 110 Flip 0 -> 1 and 1 -> 0, we get 001.
#   Binary 001 = Decimal 1
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say binaryFlip($_) for @ARGV;

# Doing a binary complement will set the high bits.  We can fix it with string
# operations by removing leading 1s.  Or we can do it in binary by figuring
# out the highest bit that is set in $n and masking the rest.
sub binaryFlip($n)
{
    my $fn = ((~$n) & maskUpTo($n));
}

# Return a bitmask that will include $n.
# Find the highest bit set in $n and make a bitmask in which
# all the bits including and to the right of that are 1.
sub maskUpTo($n)
{
    my $mask = 1;
    $mask = (($mask << 1) | 1 ) while ( $n >>= 1 );
    return $mask;
}

sub runTest
{
    use Test2::V0;

    is( maskUpTo(   1),       0x0001,     "Mask 1");
    is( maskUpTo(   2),       0x0003,     "Mask 2");
    is( maskUpTo(   5),       0x0007,     "Mask 5");
    is( maskUpTo(  27),       0x001f,     "Mask 27");
    is( maskUpTo(4180),       0x1fff,     "Mask 4180");
    is( maskUpTo(0x15555555), 0x1fffffff, "Mask 29 bits");

    is( binaryFlip(0),                  1, "Flip 0");
    is( binaryFlip(1),                  0, "Flip 1");
    is( binaryFlip(5),                  2, "Example 1");
    is( binaryFlip(4),                  3, "Example 2");
    is( binaryFlip(6),                  1, "Example 3");
    is( binaryFlip(0x15555555), 0xaaaaaaa, "29 bit number");
    is( binaryFlip(0x1555555555555), 0xaaaaaaaaaaaa, "48 bit number");

    done_testing;
}


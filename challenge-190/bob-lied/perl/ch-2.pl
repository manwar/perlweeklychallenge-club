#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly challenge Week 190 Task 2 Decoded List
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an encoded string consisting of a sequence of numeric
# characters: 0..9, $s.
# Write a script to find the all valid different decodings in sorted order.
# Encoding is simply done by mapping A,B,C,D,… to 1,2,3,4,… etc.
# Example 1 Input: $s = 11 Output: AA, K
#   11 can be decoded as (1 1) or (11) i.e. AA or K
# Example 2 Input: $s = 1115 Output: AAAE, AAO, AKE, KAE, KO
#    Possible decoded data are:
#   (1 1 1 5) => (AAAE)
#   (1 1 15)  => (AAO)
#   (1 11 5)  => (AKE)
#   (11 1 5)  => (KAE)
#   (11 15)   => (KO)
# Example 3 Input: $s = 127 Output: ABG, LG
#   Possible decoded data are:
#   (1 2 7) => (ABG)
#   (12 7)  => (LG)
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

foreach (@ARGV )
{
    if ( ! m/\A[[:digit:]]+\z/ )
    {
        warn "Not numeric ($_)";
        next;
    }

    say join(", ", decode($_)->@*);
}

sub decode($s)
{
    my @result;
    my @stack;  # Stack of possible numeric arrays
    _split($s, [], \@stack, "");

    for my $word ( @stack )
    {
        push @result, join("", map { chr(ord("A") + $_ - 1) } $word->@* );
    }
    
    return \@result;
}

sub _split($s, $sofar, $stack, $indent)
{
    say "${indent}Enter _split s='$s' sofar=[@$sofar] " if $Verbose;
    my $len = length($s);
    if ( $len == 0 )
    {
        say "${indent}Pushing [@$sofar]" if $Verbose;
        push @$stack, [ @$sofar ];
        return;
    }
    if ( length($s) == 1 )
    {
        say "${indent}Pushing [@$sofar $s]" if $Verbose;
        push @$stack, [ @$sofar, 0+$s ];
        return;
    }
    # length must be at least two, take each possibility
    _split(substr($s,1), [ @$sofar, 0+substr($s,0,1) ], $stack, "  $indent");

    my $twoDigits = 0+substr($s,0,2);
    if ( $twoDigits <= 26 )
    {
        _split(substr($s,2), [ @$sofar, $twoDigits ], $stack, "  $indent");
    }
}

sub runTest
{
    use Test2::V0;

    is( decode("11"),   [ qw(AA K) ],                "Example 1 11");
    is( decode("1115"), [ qw(AAAE AAO AKE KAE KO) ], "Example 2 1115");
    is( decode("127"),  [ qw(ABG LG) ],              "Example 3 127");
    is( (grep /BOBLIED/, decode("215212954")->@*), 1, "Bob");
    done_testing;
}


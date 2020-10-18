#!perl

###############################################################################
=comment

Perl Weekly Challenge 082
=========================

Task #2
-------
*Interleave String*

Submitted by: Mohammad S Anwar

You are given 3 strings; $A, $B and $C.

Write a script to check if $C is created by interleave $A and $B.

Print 1 if check is success otherwise 0.

Example 1:

 Input:
     $A = "XY"
     $B = "X"
     $C = "XXY"

 Output: 1

EXPLANATION

 "X" (from $B) + "XY" (from $A) = $C

Example 2:

 Input:
     $A = "XXY"
     $B = "XXZ"
     $C = "XXXXZY"

 Output: 1

EXPLANATION

 "XX" (from $A) + "XXZ" (from $B) + "Y" (from $A) = $C

Example 3:

 Input:
     $A = "YX"
     $B = "X"
     $C = "XXY"

 Output: 0

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Notes:

1. It is assumed that strings $A and $B must be fully consumed by the inter-
   leaving process that creates string $C

2. The interleaving check is performed by sub interleave, which is recursive

3. Where more than one solution is possible, only the first will be given in
   the explanation: namely, the solution found by taking letters from $A before
   $B where both are valid options

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;                # Exports const()
use enum qw(A B C);
use constant VERBOSE => 1;

const my $USAGE =>
"Usage:
  perl $0 <A> <B> <C>

    <A>    First string
    <B>    Second string
    <C>    Third string: can it be created by interleaving A and B?\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 082, Task #2: Interleave String (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 3 or die "ERROR: Expected 3 command-line arguments, found " .
                         "$args\n$USAGE";

    my ($A, $B, $C) = @ARGV;

    print "Input:\n";
    print qq[    \$A = "$A"\n];
    print qq[    \$B = "$B"\n];
    print qq[    \$C = "$C"\n\n];

    my $is_interleaved = length($C) == length($A) + length($B) ?
                         interleave($A, $B, $C, \my @sequence) : 0;

    print "Output: $is_interleaved\n";

    $is_interleaved && explain($A, $B, $C, \@sequence) if VERBOSE;
}

#------------------------------------------------------------------------------
sub interleave                                           # Recursive subroutine
#------------------------------------------------------------------------------
{
    my ($A, $B, $C, $seq) = @_;
    my  $success = 0;
    my  @length  = map { length } $A, $B, $C;

    if    ($length[A] == 0)                                       # Base case 1
    {
        if ($B eq $C)
        {
            $success = 1;
            push @$seq, 'B'           if VERBOSE;
        }
    }
    elsif ($length[B] == 0)                                       # Base case 2
    {
        if ($A eq $C)
        {
            $success = 1;
            push @$seq, 'A'           if VERBOSE;
        }
    }
    else
    {
        my $A0 = substr $A, 0, 1;
        my $AA = substr $A, 1;
        my $C0 = substr $C, 0, 1;
        my $CC = substr $C, 1;

        if ($C0 eq $A0)                                      # Recursive case 1
        {
            push @$seq, 'A'           if VERBOSE;
            $success = interleave($AA, $B, $CC, $seq);
            $success or pop @$seq     if VERBOSE;
        }

        unless ($success)
        {
            my $B0 = substr $B, 0, 1;
            my $BB = substr $B, 1;

            if ($C0 eq $B0)                                  # Recursive case 2
            {
                push @$seq, 'B'       if VERBOSE;
                $success = interleave($A, $BB, $CC, $seq);
                $success or pop @$seq if VERBOSE;
            }
        }
    }

    return $success;
}

#------------------------------------------------------------------------------
sub explain
#------------------------------------------------------------------------------
{
    my ($A,  $B,  $C, $seq) =  @_;
    my ($ai, $bi, @A, @B  ) = (0, 0);

    for my $i (0 .. $#$seq - 1)
    {
        if ($seq->[$i] eq 'A')
        {
            push @A, substr $A, $ai++, 1;
            push @B, ' ';
        }
        else
        {
            push @A, ' ';
            push @B, substr $B, $bi++, 1;
        }
    }

    if ($seq->[-1] eq 'A')
    {
        push @A, substr $A, $ai;
    }
    else
    {
        push @B, substr $B, $bi;
    }

    print  "\nEXPLANATION\n";
    printf   "    \$A =  %s\n", join '', @A;
    printf   "    \$B =  %s\n", join '', @B;
    print    "    \$C =  $C\n";
}

###############################################################################


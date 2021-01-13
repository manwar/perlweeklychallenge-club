use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Notes:

1. It is assumed that strings $A and $B must be fully consumed by the inter-
   leaving process that creates string $C

2. The interleaving check is performed by sub interleave, which is recursive

3. Where more than one solution is possible, only the first will be given in
   the explanation: namely, the solution found by taking letters from $A before
   $B where both are valid options

=end comment
#==============================================================================

enum < A B C >;

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 082, Task #2: Interleave String (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    Str:D $A,      #= First  string
    Str:D $B,      #= Second string
    Str:D $C,      #= Third  string: can it be created by interleaving A and B?
)
##=============================================================================
{
    "Input:"\           .put;
    qq[    \$A = "$A"]\ .put;
    qq[    \$B = "$B"]\ .put;
    qq[    \$C = "$C"\n].put;

    my Str  @sequence;
    my Bool $is-interleaved = $C.chars == $A.chars + $B.chars   ??
                              interleave($A, $B, $C, @sequence) !! False;

    "Output: %d\n".printf: $is-interleaved ?? 1 !! 0;

    $is-interleaved && explain($A, $B, $C, @sequence) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub interleave( Str:D $A, Str:D $B, Str:D $C, Array:D[Str:D] $seq --> Bool:D )
#------------------------------------------------------------------------------
{
    my Bool $success = False;
    my UInt @length  = ($A, $B, $C).map: { .chars };

    if    @length[A] == 0                                         # Base case 1
    {
        if $B eq $C
        {
            $success = True;
            $seq.push: 'B'              if $VERBOSE;
        }
    }
    elsif @length[B] == 0                                         # Base case 2
    {
        if $A eq $C
        {
            $success = True;
            $seq.push: 'A'              if $VERBOSE;
        }
    }
    else
    {
        my Str $A0 = $A.substr: 0, 1;
        my Str $AA = $A.substr: 1;
        my Str $C0 = $C.substr: 0, 1;
        my Str $CC = $C.substr: 1;

        if $C0 eq $A0                                        # Recursive case 1
        {
            $seq.push: 'A'              if $VERBOSE;
            $success = interleave($AA, $B, $CC, $seq);
            $success or $seq.pop        if $VERBOSE;
        }

        unless $success
        {
            my $B0 = $B.substr: 0, 1;
            my $BB = $B.substr: 1;

            if $C0 eq $B0                                    # Recursive case 2
            {
                $seq.push: 'B'          if $VERBOSE;
                $success = interleave($A, $BB, $CC, $seq);
                $success or $seq.pop if $VERBOSE;
            }
        }
    }

    return $success;
}

#------------------------------------------------------------------------------
sub explain( Str:D $A, Str:D $B, Str:D $C, Array:D[Str:D] $seq )
#------------------------------------------------------------------------------
{
    my (UInt $ai, UInt $bi) = 0, 0;
    my (Str  @A,  Str  @B);

    for 0 .. $seq.end - 1 -> UInt $i
    {
        if $seq[$i] eq 'A'
        {
            @A.push: $A.substr: $ai++, 1;
            @B.push: ' ';
        }
        else
        {
            push @A, ' ';
            push @B, $B.substr: $bi++, 1;
        }
    }

    if $seq[*-1] eq 'A'
    {
        @A.push: $A.substr: $ai;
    }
    else
    {
        @B.push: $B.substr: $bi;
    }

    "\nEXPLANATION"\ .put;
    "    \$A =  %s\n".printf: @A.join: '';
    "    \$B =  %s\n".printf: @B.join: '';
    "    \$C =  $C"\ .put;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

###############################################################################

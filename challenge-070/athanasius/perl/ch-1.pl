#!perl

################################################################################
=comment

Perl Weekly Challenge 070
=========================

Task #1
-------
*Character Swapping*

*Submitted by:* Mohammad S Anwar

You are given a string $S of size $N.

You are also given swap count $C and offset $O such that $C >= 1, $O >= 1,
$C <= $O and $C + $O <= $N.

*UPDATE: 2020-07-20 16:10:00*
*Pete Houston suggested to put additional constraint i.e. $C <= $O. He presented
the use case $S = 'abcd', $C = 2, $O = 1.*

Write a script to perform character swapping like below:

 $S[ 1 % $N ] <=> $S[ (1 + $O) % $N ]
 $S[ 2 % $N ] <=> $S[ (2 + $O) % $N ]
 $S[ 3 % $N ] <=> $S[ (3 + $O) % $N ]
 ...
 ...
 $S[ $C % $N ] <=> $S[ ($C + $O) % $N ]

*Example 1*

 Input:
     $S = 'perlandraku'
     $C = 3
     $O = 4

 Character Swapping:
     swap 1: e <=> n = pnrlaedraku
     swap 2: r <=> d = pndlaerraku
     swap 3: l <=> r = pndraerlaku

 Output:
     pndraerlaku

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use constant DISPLAY_SWAP => 1;

const my $USAGE =>
"Usage:
  perl $0 <S> <C> <O>

    <S>    Non-empty string
    <C>    Swap count: integer >= 1
    <O>    Offset: integer >= 1 such that C <= O and C + O <= |S|\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 070, Task #1: Character Swapping (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my ($S, $C, $O) = parse_command_line();

    print "Input:\n    \$S = '$S'\n    \$C = $C\n    \$O = $O\n\n";

    print "Character Swapping:\n" if DISPLAY_SWAP;

    $S = swap($S, $_, $O) for 1 .. $C;
    
    print "\n"                    if DISPLAY_SWAP;
    print "Output:\n    $S\n";
}

#-------------------------------------------------------------------------------
sub swap
#-------------------------------------------------------------------------------
{
    my ($S, $idx, $O) = @_;

    my $N     =  length $S;
    my $idx_l =  $idx       % $N;
    my $idx_r = ($idx + $O) % $N;
    my $chr_l =  substr($S, $idx_l, 1);
    my $chr_r =  substr($S, $idx_r, 1);

    substr($S, $idx_l, 1, $chr_r);
    substr($S, $idx_r, 1, $chr_l);

    print "    swap: $idx: $chr_l <=> $chr_r = $S\n" if DISPLAY_SWAP;

    return $S;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    scalar @ARGV == 3               or die $USAGE;

    my ($S, $C, $O) = @ARGV;
    my  $N          = length $S;

    $N > 0                          or die $USAGE;

    /\A$RE{num}{int}\z/ && $_ >= 1  or die $USAGE for $C, $O;

    $C <= $O && ($C + $O) <= $N     or die $USAGE;

    return ($S, $C, $O);
}

################################################################################

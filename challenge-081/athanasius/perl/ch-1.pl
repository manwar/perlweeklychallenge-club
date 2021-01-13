#!perl

###############################################################################
=comment

Perl Weekly Challenge 081
=========================

Task #1
-------
*Common Base String*

Submitted by: Mohammad S Anwar

You are given 2 strings, $A and $B.

Write a script to find out common base strings in $A and $B.

    A substring of a string $S is called base string if repeated concatenation
    of the substring results in the string.

Example 1:

 Input:
     $A = "abcdabcd"
     $B = "abcdabcdabcdabcd"

 Output:
     ("abcd", "abcdabcd")

Example 2:

 Input:
     $A = "aaa"
     $B = "aa"

 Output:
     ("a")

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

                                       # Exports:
use strict;
use warnings;
use Const::Fast;                       # const()
use Math::Prime::Util qw( divisors );
use Set::Scalar;                       # infix "*" (overloaded for set inter-
                                       #             section), members(), new()

const my $USAGE =>
"Usage:
  perl $0 <A> <B>

    <A>    First string
    <B>    Second string\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 081, Task #1: Common Base String (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($A, $B)   = parse_command_line();

    # (1) Display the input

    print qq[Input:\n    \$A = "$A"\n    \$B = "$B"\n\n];

    # (2) Find the *lengths* of all possible base strings common to $A and $B

    my $A_lengths = Set::Scalar->new( divisors(length $A) );
    my $B_lengths = Set::Scalar->new( divisors(length $B) );
    my @lengths   = sort { $a <=> $b } ($A_lengths * $B_lengths)->members;

    # (3) Find the base strings common to $A and $B using the substring lengths
    #     just calculated

    my $A_bases   = Set::Scalar->new( find_base_strings($A, \@lengths) );
    my $B_bases   = Set::Scalar->new( find_base_strings($B, \@lengths) );
    my @bases     = sort +($A_bases * $B_bases)->members;

    # (4) Display the common base strings

    printf "Output:\n    (%s)\n", join ', ', map { qq["$_"] } @bases;
}

#------------------------------------------------------------------------------
sub find_base_strings
#------------------------------------------------------------------------------
{
    my ($string, $lengths) = @_;
    my  $total_length      = length $string;
    my  @base_strings;

    for my $length (@$lengths)
    {
        my $substring  = substr $string, 0, $length;
        my $new_string = $substring x int($total_length / $length);

        push @base_strings, $substring if $new_string eq $string;
    }

    return @base_strings;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;

    $args == 2
        or die "ERROR: Incorrect number ($args) of command-line arguments\n" .
               $USAGE;

    return @ARGV;
}

###############################################################################

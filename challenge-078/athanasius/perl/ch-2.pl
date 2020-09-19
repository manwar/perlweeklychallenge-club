#!perl

###############################################################################
=comment

Perl Weekly Challenge 078
=========================

Task #2
-------
*Left Rotation*

Submitted by: Mohammad S Anwar

You are given array @A containing positive numbers and @B containing one or
more indices from the array @A.

Write a script to left rotate @A so that the number at the first index of @B
becomes the first element in the array. Similary, left rotate @A again so that
the number at the second index of @B becomes the first element in the array.

Example 1:

 Input:
     @A = (10 20 30 40 50)
     @B = (3 4)

Explanation:

 a) We left rotate the 3rd index element (40) in the @A to make it 0th index
    member in the array.
         [40 50 10 20 30]

 b) We left rotate the 4th index element (50) in the @A to make it 0th index
    member in the array.
         [50 10 20 30 40]

 Output:
     [40 50 10 20 30]
     [50 10 20 30 40]

Example 2:

 Input:
     @A = (7 4 2 6 3)
     @B = (1 3 4)

Explanation:

 a) We left rotate the 1st index element (4) in the @A to make it 0th index
    member in the array.
         [4 2 6 3 7]

 b) We left rotate the 3rd index element (6) in the @A to make it 0th index
    member in the array.
         [6 3 7 4 2]

 c) We left rotate the 4th index element (3) in the @A to make it 0th index
    member in the array.
         [3 7 4 2 6]

 Output:
     [4 2 6 3 7]
     [6 3 7 4 2]
     [3 7 4 2 6]

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

                                    # Exports:
use strict;
use warnings;
use Const::Fast;                    # const()
use Getopt::Long;                   # GetOptions()
use Regexp::Common qw( number );    # %RE{num}

#------------------------------------------------------------------------------
# Constant
#------------------------------------------------------------------------------

const my $USAGE =>
"Usage:
  perl $0 [-A <Str>] [-B <Str>]

    -A <Str>    A whitespace-separated array of positive integers
    -B <Str>    A whitespace-separated array of indices into array A\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 078, Task #2: Left Rotation (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($A,   $B) = parse_command_line();
    my  @A_orig   = @$A;
    my  @B        = @$B;

    print  "Input:\n";
    printf "    \@A = (%s)\n",   join ' ', @A_orig;
    printf "    \@B = (%s)\n\n", join ' ', @B;

    print  "Output:\n";

    for my $b (@B)
    {
        my @A = @A_orig;

        # Rotate the array by slicing @A into 2 parts:
        #
        #   (1) from the element at index $b to the end of the array
        #   (2) from the initial (i.e., zeroth) element to the element
        #       immediately before index $b
        #
        # and joining the slices

        @A = @A[$b .. $#A, 0 .. $b - 1];

        printf "    [%s]\n", join ' ', @A;
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my ($A, $B);

    GetOptions
    (
        'A=s' => \$A,
        'B=s' => \$B,
    )                  or error('Invalid command line arguments');

    defined $A         or error('A is missing');
    defined $B         or error('B is missing');
    scalar  @ARGV == 0 or error('Extra command line arguments found');

    my @A = parse_A($A);
    my @B = parse_B($B, $#A);

    return (\@A, \@B);
}

#------------------------------------------------------------------------------
sub parse_A
#------------------------------------------------------------------------------
{
    my ($A) = @_;
    my  @A;

    for my $s (split / \s+ /x, $A)
    {
        next if $s eq '';         # Ignore leading or trailing whitespace

        $s =~ /\A$RE{num}{int}\z/ or error("Non-integer '$s' in \@A");
        $s >  0                   or error("Non-positive integer '$s' in \@A");

        push @A, $s;
    }

    return @A;
}

#------------------------------------------------------------------------------
sub parse_B
#------------------------------------------------------------------------------
{
    my ($B, $max) = @_;
    my  @B;

    for my $s (split / \s+ /x, $B)
    {
        next if $s eq '';         # Ignore leading or trailing whitespace

        $s =~ /\A$RE{num}{int}\z/
                    or error("Non-integer '$s' in \@B");
        $s >= 0     or error("Index $s out of range in \@B (must be >= 0)");
        $s <= $max  or error("Index $s out of range in \@B (must be <= $max)");

        push @B, $s;
    }

    return @B;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

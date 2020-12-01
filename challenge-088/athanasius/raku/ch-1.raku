use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 088
=========================

Task #1
-------
*Array of Product*

Submitted by: Mohammad S Anwar

You are given an array of positive integers @N.

Write a script to return an array @M where $M[i] is the product of all elements
of @N except the index $N[i].

Example 1:

 Input:
     @N = (5, 2, 1, 4, 3)
 Output:
     @M = (24, 60, 120, 30, 40)

     $M[0] = 2 x 1 x 4 x 3 = 24
     $M[1] = 5 x 1 x 4 x 3 = 60
     $M[2] = 5 x 2 x 4 x 3 = 120
     $M[3] = 5 x 2 x 1 x 3 = 30
     $M[4] = 5 x 2 x 1 x 4 = 40

Example 2:

 Input:
     @N = (2, 1, 4, 3)
 Output:
     @M = (12, 24, 6, 8)

     $M[0] = 1 x 4 x 3 = 12
     $M[1] = 2 x 4 x 3 = 24
     $M[2] = 2 x 1 x 3 = 6
     $M[3] = 2 x 1 x 4 = 8

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption: "Positive" integers are those which are greater than zero.

Algorithm:  First find $product, the product of *all* the elements in @N; then,
            for each element in @N, divide $product by that element's value to
            get the desired sub-product for that index, and store it in @M.

=end comment
#==============================================================================

subset Positive of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 088, Task #1: Array of Product (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| A non-empty, unsorted array of positive integers

    *@N where { @N.elems > 0 && .all ~~ Positive:D }
)
#==============================================================================
{
    my Positive @n = @N;    # Change element containers from IntStr to Positive

    print-array('Input',  @n);

    my Positive $product = [*] @n;                     # List reduction
    my Positive @M;

    @M.push: $product div @n[$_] for 0 .. @n.end;      # Note: integer division

    print-array('Output', @M);
}

#------------------------------------------------------------------------------
sub print-array( Str:D $title, Array:D[Positive:D] $array )
#------------------------------------------------------------------------------
{
    "$title:".put;

    "    (%s)\n".printf: $array.join: ', ';
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################

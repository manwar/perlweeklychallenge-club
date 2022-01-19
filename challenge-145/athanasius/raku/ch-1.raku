use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 145
=========================

TASK #1
-------
*Dot Product*

Submitted by: Mohammad S Anwar

You are given 2 arrays of same size, @a and @b.

Write a script to implement Dot Product.

Example:

 @a = (1, 2, 3);
 @b = (4, 5, 6);

 $dot_product = (1 * 4) + (2 * 5) + (3 * 6) => 4 + 10 + 18 => 32

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
Each of the two arrays must be entered on the command line as a string contain-
ing comma-separated real numbers. Each comma separator may, optionally, be
followed by whitespace.

Solution
--------
The dot product calculation is performed in this expression:

    [+] @a Z* @b

which uses two of Raku's built-in metaoperators:
    - the zip       metaoperator  Z*; and
    - the reduction metaoperator [+]

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 145, Task #1: Dot Product (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D $a,            #= Comma-separated list of n real numbers
    Str:D $b             #= Comma-separated list of n real numbers
)
#==============================================================================
{
    my Real @a = parse-str( $a );
    my Real @b = parse-str( $b );

    @a.elems == @b.elems
        or error( 'The input lists have different sizes' );

    "Input:  @a = (%s)\n".printf: @a.join: ', ';
    "        @b = (%s)\n".printf: @b.join: ', ';

    "Output: %d\n".printf: [+] @a Z* @b;
}

#------------------------------------------------------------------------------
sub parse-str( Str:D $str --> Array:D[Real:D] )
#------------------------------------------------------------------------------
{
    my Str  @list = $str.split: / \, \s* /, :skip-empty;
    my Real @nums;

    for @list -> Str $s
    {
        val( $s ) ~~ (IntStr, NumStr, RatStr).any
            or error( qq["$s" is not a valid number] );

        @nums.push: val( $s );
    }

    return @nums;
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit;
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

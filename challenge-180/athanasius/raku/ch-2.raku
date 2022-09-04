use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 180
=========================

TASK #2
-------
*Trim List*

Submitted by: Mohammad S Anwar

You are given list of numbers, @n and an integer $i.

Write a script to trim the given list where element is less than or equal to
the given integer.

Example 1

  Input: @n = (1,4,2,3,5) and $i = 3
  Output: (4,5)

Example 2

  Input: @n = (9,0,6,2,3,8,5) and $i = 4
  Output: (9,6,8,5)

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption
----------
$i must be an integer (as specified), but the elements of @n may be any real
numbers.

Interface
---------
$i is given first on the command line, followed by the elements of @n.
Note: If $i is negative, it must be preceded by "--" to prevent it from being
interpreted as a command-line switch.

=end comment
#==============================================================================

my Str constant $SEP = ', ';

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 180, Task #2: Trim List (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Int:D $i,              #= An integer (must be preceded by "--" if negative)

    *@n where { .elems > 0 && .all ~~ Real:D }      #= One or more real numbers
)
#==============================================================================
{
    "Input:  @n = (%s) and \$i = %d\n".printf: @n.join( $SEP ), $i;

    "Output: (%s)\n".printf: @n.grep( { $_ > $i } ).join: $SEP;
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

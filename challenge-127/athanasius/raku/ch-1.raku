use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 127
=========================

TASK #1
-------
*Disjoint Sets*

Submitted by: Mohammad S Anwar

You are given two sets with unique integers.

Write a script to figure out if they are disjoint.

    The two sets are disjoint if they don’t have any common members.

Example

 Input: @S1 = (1, 2, 5, 3, 4)
        @S2 = (4, 6, 7, 8, 9)
 Output: 0 as the given two sets have common member 4.

 Input: @S1 = (1, 3, 5, 7, 9)
        @S2 = (0, 2, 4, 6, 8)
 Output: 1 as the given two sets do not have common member.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Note
----
Input set elements are verified as integers, but no check is made for dupli-
cates as these are automatically removed during set creation.

Algorithm
---------
Set intersection using Raku's core Set class.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 127, Task #1: Disjoint Sets (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D $S1,           #= Set 1: a string of the form "( int-a, int-b, ... )"
    Str:D $S2            #= Set 2: a string of the form "( int-m, int-n, ... )"
)
#==============================================================================
{
    my @S1 = parse-set-str( $S1 );
    my @S2 = parse-set-str( $S2 );

    "Input:  \@S1 = (%s)\n".printf: @S1.join: ', ';
    "        \@S1 = (%s)\n".printf: @S2.join: ', ';

    my Set[Int] $set1  = Set[Int].new: @S1;
    my Set[Int] $set2  = Set[Int].new: @S2;
    my Set[Int] $inter = $set1 ∩ $set2;                      # Set intersection

    if $inter.elems == 0
    {
        ('Output: 1 (disjoint) as the given two sets do not have any common ' ~
         'members').put;
    }
    else
    {
        ('Output: 0 (not disjoint) as the given two sets have the common ' ~
         "member%s %s\n").printf: $inter.elems == 1 ?? '' !! 's',
                                  $inter.keys.sort.join: ', ';
    }
}

#------------------------------------------------------------------------------
sub parse-set-str( Str:D $S --> Array:D[Int:D] )
#------------------------------------------------------------------------------
{
    my Int @array;

    $S ~~ / ^ \( (.*) \) $ /
        or error( qq[Malformed string "$S"] );

    for $0.split: / \, \s* /, :skip-empty
    {
        if val( $_ ).^name eq 'IntStr'
        {
            @array.push: .Int;
        }
        else
        {
            error( qq[Element "$_" is not an integer] );
        }
    }

    return @array;
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

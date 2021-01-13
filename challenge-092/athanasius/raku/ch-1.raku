use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 092
=========================

Task #1
-------
*Isomorphic Strings*

Submitted by: Mohammad S Anwar

You are given two strings $A and $B.

Write a script to check if the given strings are *Isomorphic*
(https://www.educative.io/edpresso/how-to-check-if-two-strings-are-isomorphic).
Print 1 if they are otherwise 0.

Example 1:

 Input: $A = "abc"; $B = "xyz"
 Output: 1

Example 2:

 Input: $A = "abb"; $B = "xyy";
 Output: 1

Example 3:

 Input: $A = "sum"; $B = "add"
 Output: 0

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 092, Task #1: Isomorphic Strings (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D $A,                         #= First  string
    Str:D $B,                         #= Second string
)
#==============================================================================
{
    qq[Input:  \$A = "$A"; \$B = "$B"].put;

    "Output: %d\n".printf: strings-are-isomorphic($A, $B) ?? 1 !! 0;
}

#------------------------------------------------------------------------------
sub strings-are-isomorphic( Str:D $A, Str:D $B --> Bool:D )
#------------------------------------------------------------------------------
{
    my Str @A = $A.split: '', :skip-empty;
    my Str @B = $B.split: '', :skip-empty;

    return False if @A.elems != @B.elems;

    my Str     %map;
    my SetHash $set;                      # or:  my SetHash $set = SetHash.new;

    for 0 .. @A.end -> UInt $i
    {
        my Str $c1 = @A[$i];
        my Str $c2 = @B[$i];

        if %map{$c1}:exists
        {
            return False if %map{$c1} ne $c2;
        }
        else
        {
            return False if $set{$c2};    # or:  return False if $c2 ∈ $set;

            %map{$c1} = $c2;
            $set.set:   $c2;
        }
    }

    return True;
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

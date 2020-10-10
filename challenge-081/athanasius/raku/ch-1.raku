use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 081, Task #1: Common Base String (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    Str:D $A,                       #= First string
    Str:D $B,                       #= Second string
)
##=============================================================================
{
    # (1) Display the input

    qq[Input:\n    \$A = "$A"\n    \$B = "$B"\n].put;

    # (2) Find the *lengths* of all possible base strings common to $A and $B

    my UInt @common-lengths = (find-divisors($A).Set ∩
                               find-divisors($B).Set).keys.sort;

    # (3) Find the base strings common to $A and $B using the substring lengths
    #     just calculated

    my Str @common-bases =
                (find-base-strings($A, @common-lengths).Set ∩
                 find-base-strings($B, @common-lengths).Set).keys.sort;

    # (4) Display the common base strings

    "Output:\n    (%s)\n".printf: @common-bases.map( { qq["$_"] } ).join: ', ';
}

#------------------------------------------------------------------------------
sub find-base-strings
(
    Str:D           $string,
    Array:D[UInt:D] $lengths,
--> Array:D[Str:D]
)
#------------------------------------------------------------------------------
{
    my UInt $total-length = $string.chars;
    my Str  @base-strings;
    
    for @$lengths -> UInt $length
    {
        my Str $substring  = substr $string, 0, $length;
        my Str $new-string = $substring x ($total-length / $length);

        @base-strings.push: $substring if $new-string eq $string;
    }

    return @base-strings;
}

#------------------------------------------------------------------------------
sub find-divisors( Str:D $string --> Seq:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt $integer = $string.chars;

    my UInt @divisors = 1, $integer;

    for 2 .. $integer.sqrt.floor -> UInt $i
    {
        if $integer % $i == 0
        {
            my UInt $j = ($integer / $i).floor;

            @divisors.push: $i;
            @divisors.push: $j unless $j == $i;
        }
    }

    return @divisors.sort;
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

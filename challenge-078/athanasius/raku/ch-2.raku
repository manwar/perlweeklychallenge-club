use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 078, Task #2: Left Rotation (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    Str:D :$A,          #= A whitespace-separated array of positive integers
    Str:D :$B,          #= A whitespace-separated array of indices into array A
)
##=============================================================================
{
    my UInt @A-orig = parse-A($A);
    my UInt @B      = parse-B($B, @A-orig.end);

    'Input:'.put;

    "    \@A = (%s)\n"  .printf: @A-orig.join: ' ';
    "    \@B = (%s)\n\n".printf: @B     .join: ' ';

    'Output:'.put;

    for @B -> UInt $b
    {
        my UInt @A = @A-orig;

        # Raku's built-in rotate() method:
        #
        #     multi method rotate(List:D: Int:D $n = 1 --> List:D)
        #
        # "Returns the list rotated by $n elements" - i.e., left-rotated, which
        # makes it ideal for solving this Task

        @A = @A.rotate($b);

        "    [%s]\n".printf: @A.join: ' ';
    }
}

#------------------------------------------------------------------------------
sub parse-A( Str:D $A --> Array:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt @A;

    for $A.split: / \s+ /, :skip-empty -> Str $a
    {
        my Str $v = val($a);

        $v.^name eq 'IntStr' or error("Non-integer '$a' in \@A");

        my Int $i = $v.Int;

        $i > 0               or error("Non-positive '$i' in \@A");

        @A.push: $i;
    }

    return @A;
}

#------------------------------------------------------------------------------
sub parse-B( Str:D $B, UInt:D $max --> Array:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt @B;

    for $B.split: / \s+ /, :skip-empty -> Str $b
    {
        my Str $v = val($b);

        $v.^name eq 'IntStr'
                    or error("Non-integer '$b' in \@B");

        my Int $i = $v.Int;

        $i >= 0     or error("Index $i out of range in \@B (must be >= 0)");
        $i <= $max  or error("Index $i out of range in \@B (must be <= $max)");

        @B.push: $i;
    }

    return @B;
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

###############################################################################

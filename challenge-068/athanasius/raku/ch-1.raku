use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 068
=========================

Task #1
-------
*Zero Matrix*

*Submitted by:* Mohammad S Anwar

You are given a matrix of size M x N having only 0s and 1s.

Write a script to set the entire row and column to 0 if an element is 0.

*Example 1*

 Input: [1, 0, 1]
        [1, 1, 1]
        [1, 1, 1]

 Output: [0, 0, 0]
         [1, 0, 1]
         [1, 0, 1]

*Example 2*

 Input: [1, 0, 1]
        [1, 1, 1]
        [1, 0, 1]

 Output: [0, 0, 0]
         [1, 0, 1]
         [0, 0, 0]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN
(
    UInt:D $M where { $M > 0 },          #= (UInt > 0) Matrix height (rows)
    UInt:D $N where { $N > 0 },          #= (UInt > 0) Matrix width (cols)
          *@input,                       #= ( [0|1]+ ) Matrix elements
)
#===============================================================================
{
    "Challenge 068, Task #1: Zero Matrix (Raku)\n".put;

    @input.elems  == $M * $N or die $*USAGE;
    $_ == 0 || $_ == 1       or die $*USAGE for @input;

    my @matrix;

    for 0 .. $M - 1 -> UInt $row
    {
        my UInt $start = $row   * $N;
        my UInt $end   = $start + $N - 1;

        @matrix.push: [ @input[ $start .. $end ] ];
    }

    print-matrix('Input',  $M, $N, @matrix);

    zero-matrix($M, $N, @matrix);

    ''.put;
    print-matrix('Output', $M, $N, @matrix);
}

#-------------------------------------------------------------------------------
sub print-matrix(Str:D $title, UInt:D $rows, UInt:D $cols, @matrix)
#-------------------------------------------------------------------------------
{
    "%s:\n".printf: $title if $title;

    for 0 .. $rows - 1 -> UInt $row
    {
        "[%s]\n".printf: @matrix[ $row; 0 .. $cols - 1 ].join: ', ';
    }
}

#-------------------------------------------------------------------------------
sub zero-matrix(UInt:D $rows, UInt:D $cols, @matrix)
#-------------------------------------------------------------------------------
{
    my (%zero-rows, %zero-cols);

    for 0 .. $rows - 1 -> UInt $row
    {
        for 0 .. $cols - 1 -> UInt $col
        {
            if @matrix[$row; $col] == 0
            {
                ++%zero-rows{ $row };
                ++%zero-cols{ $col };
            }
        }
    }

    for %zero-rows.keys.map: { .Int } -> UInt $row
    {
        @matrix[$row; $_] = 0 for 0 .. $cols - 1;
    }

    for %zero-cols.keys.map: { .Int } -> UInt $col
    {
        @matrix[$_; $col] = 0 for 0 .. $rows - 1;
    }
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

################################################################################

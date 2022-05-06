use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 163
=========================

TASK #2
-------
*Summations*

Submitted by: Mohammad S Anwar

You are given a list of positive numbers, @n.

Write a script to find out the summations as described below.

Example 1

  Input: @n = (1, 2, 3, 4, 5)
  Output: 42

      1 2 3  4  5
        2 5  9 14
          5 14 28
            14 42
               42

  The nth Row starts with the second element of the (n-1)th row.
  The following element is sum of all elements except first element of previous
  row.
  You stop once you have just one element in the row.

Example 2

  Input: @n = (1, 3, 5, 7, 9)
  Output: 70

      1 3  5  7  9
        3  8 15 24
           8 23 47
             23 70
                70

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption
----------
"Positive numbers" are integers greater than zero.

=end comment
#==============================================================================

subset Pos of Int where * > 0;

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 163, Task #2: Summations (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@n where { +@n > 0 && .all ~~ Pos:D }       #= A list of positive integers
)
#==============================================================================
{
    "Input:  @n = (%s)\n".printf: @n.join: ', ';

    my Pos        @last = @n.map: { .Int };
    my Pos        @next = @last[ 1 ];
    my Array[Pos] @triangle;
                  @triangle.push: @last.clone;

    while +@last > 1
    {
        for 2 .. @last.end -> UInt $i
        {
            @next.push: @next[ $i - 2 ] + @last[ $i ];
        }

        @triangle.push: @next.clone;

        @last = @next;
        @next = @last[ 1 ];
    }

    "Output: %d\n".printf: @triangle[ *-1; 0 ];

    display-triangle( @triangle ) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub display-triangle( Array:D[Array:D[Pos:D]] $triangle )
#------------------------------------------------------------------------------
{
    # Pre-calculate the maximum width of each column

    my UInt @col-widths;

    for 0 .. $triangle[ 0 ].end -> $col
    {
        @col-widths[ $col ] = $triangle[ $col; 0 ].chars;
    }

    # Print the triangle

    put();
    my UInt $row-idx = 0;

    for @$triangle -> Array[Pos] $row
    {
        '   '.print;

        for 0 .. $row-idx - 1 -> UInt $i
        {
            ' %*s'.printf: @col-widths[ $i ], '';
        }

        for 0 .. $row.end -> UInt $j
        {
            ' %*s'.printf: @col-widths[ $j + $row-idx ], $row[ $j ];
        }

        put();
        ++$row-idx;
    }
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

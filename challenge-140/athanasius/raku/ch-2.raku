use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 140
=========================

TASK #2
-------
*Multiplication Table*

Submitted by: Mohammad S Anwar

You are given 3 positive integers, $i, $j and $k.

Write a script to print the $kth element in the sorted multiplication table of
$i and $j.

Example 1

  Input: $i = 2; $j = 3; $k = 4
  Output: 3

  Since the multiplication of 2 x 3 is as below:

      1 2 3
      2 4 6

  The sorted multiplication table:

      1 2 2 3 4 6

  Now the 4th element in the table is "3".

Example 2

  Input: $i = 3; $j = 3; $k = 6
  Output: 4

  Since the multiplication of 3 x 3 is as below:

      1 2 3
      2 4 6
      3 6 9

  The sorted multiplication table:

      1 2 2 3 3 4 6 6 9

  Now the 6th element in the table is "4".

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption
----------
A "positive integer" is an integer greater than or equal to one.

Configuration
-------------
Set $VERBOSE to True (the default) to display an explanation of the output like
that in the Examples. Set it to False to remove the explanation.

Algorithm
---------
(Straightforward:) Construct the multiplication table; sort it in ascending
numerical order; then index it to obtain the desired output.

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

subset Positive of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 140, Task #2: Multiplication Table (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Positive:D $i,     #= Positive integer: maximum multiplier   for the  table
    Positive:D $j,     #= Positive integer: maximum multiplicand for the  table
    Positive:D $k where * <= $i * $j
                       #= Positive integer: 1-based index into the sorted table
)
#==============================================================================
{
    "Input:  \$i = $i; \$j = $j; \$k = $k".put;

    my Positive @table;

    for 1 .. $i -> Positive $row                       # Create the table
    {
        for 1 .. $j -> Positive $col
        {
            @table.push: $col * $row;
        }
    }

    my Positive @sorted  = @table.sort;                # Sort the table
    my Positive $element = @sorted[ $k - 1 ];          # Index the sorted table

    "Output: $element".put;

    explain( $i, $j, $k, @table, @sorted, $element ) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub explain
(
    Positive:D          $i,
    Positive:D          $j,
    Positive:D          $k where * <= $i * $j,
    Array:D[Positive:D] $table,
    Array:D[Positive:D] $sorted,
    Positive:D          $element
)
#------------------------------------------------------------------------------
{
    "\nSince the multiplication of $i x $j is as below:\n".put;

    # (1) Pre-compute table column widths

    my Positive @widths;

    for ($i - 1) * $j .. $i * $j - 1 -> UInt $idx
    {
        @widths.push: $table[ $idx ].chars;
    }

    # (2) Print the table

    for 0 .. $i - 1 -> UInt $row
    {
        '   '.print;

        for $row * $j .. ($row + 1) * $j - 1 -> UInt $idx
        {
            ' %*d'.printf: @widths[ $idx % $j ], $table[ $idx ];
        }

        put();
    }

    # (3) Print the contents of the sorted table

    "\nThe sorted multiplication table:\n\n    %s\n".printf: $sorted.join: ' ';

    # (4) Explain the output

    qq[\nNow the %s element in the table is "%d".\n].printf:
        ordinal( $k ), $element;
}

#------------------------------------------------------------------------------
sub ordinal( Positive:D $n --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $suffix = 'th';
    my Str $digit0 = $n.substr: *-1, 1;

    if $n.chars < 2 || $n.substr( *-2, 1 ) ne '1'
    {
        $suffix = $digit0 eq '1' ?? 'st' !!
                  $digit0 eq '2' ?? 'nd' !!
                  $digit0 eq '3' ?? 'rd' !! 'th';
    }

    return $n ~ $suffix;
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

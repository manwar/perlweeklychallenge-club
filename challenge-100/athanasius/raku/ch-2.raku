use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 100
=========================

Task #2
-------
*Triangle Sum*

Submitted by: Mohammad S Anwar

You are given triangle array.

Write a script to find the minimum path sum from top to bottom.

When you are on index i on the current row then you may move to either index i
or index i + 1 on the next row.

Example 1:

 Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
 Output: 8

 Explanation: The given triangle

             1
            2 4
           6 4 9
          5 1 7 2

 The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8

              [1]
            [2]  4
            6 [4] 9
           5 [1] 7 2

Example 2:

 Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
 Output: 7

 Explanation: The given triangle

             3
            3 1
           5 2 3
          4 3 1 3

 The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7

              [3]
             3  [1]
            5 [2] 3
           4 3 [1] 3

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm

Although the path sum is from top to bottom, the algorithm for finding the min-
imum path sum proceeds from bottom to top. For each row, starting at the second
last and moving up, each element is summed with the smaller of the two elements
immediately below it. When the top (i.e., first) row is reached, the final sum
is guaranteed to be the minimum.

Output

If the constant $VERBOSE is True, the output is supplemented with a summary of
the elements in the minimum path sum, followed by a table of moves (left or
right) from top to bottom of the triangle.

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 100, Task #2: Triangle Sum (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D $triangle         #= String representing a non-empty triangular array
                            #= of numbers
)
#==============================================================================
{
    my Array[Real] @reals    = get-array( $triangle );
    my Array[Hash] @triangle = Array[Hash].new xx @reals.elems;

    "Input:  %s\n".printf: @reals.gist;

    for 0 .. @reals[ @reals.end ].end -> UInt $col
    {
        @triangle[ @reals.end; $col ] =
            {
                VALUE => @reals[ @reals.end; $col ],
                SUM   => @reals[ @reals.end; $col ],
                INDEX => Nil,
            };
    }

    for (0 .. @reals.end - 1).reverse -> UInt $row
    {
        for 0 .. @reals[ $row ].end -> UInt $col
        {
            my Real $lhs  = @triangle[ $row + 1; $col     ]<SUM>;
            my Real $rhs  = @triangle[ $row + 1; $col + 1 ]<SUM>;
            my Bool $left = $lhs <= $rhs;  

            @triangle[ $row; $col ] =
                {
                    VALUE => @reals[ $row; $col ],
                    SUM   => @reals[ $row; $col ] + ($left ?? $lhs !! $rhs),
                    INDEX => $left ?? $col !! $col + 1;
                };
        }
    }

    "Output: %s\n".printf: @triangle[ 0; 0 ]<SUM>;

    show-path( @triangle ) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub show-path( Array:D[Array:D[Hash:D]] $triangle )
#------------------------------------------------------------------------------
{
    my Real $first = $triangle[ 0; 0 ]<VALUE>;
    my Real @terms = $first;
    my Str  $path  = "\t          $first\n";
    my UInt $col   = 0;

    for 1 .. $triangle.end -> UInt $row
    {
        my UInt $next-col  = $triangle[ $row - 1; $col ]<INDEX>;
        my Str  $direction = 'Left';

        if $next-col != $col
        {
            $direction = 'Right';
            ++$col;
        }

        @terms.push: $triangle[ $row; $col ]<VALUE>;

        $path ~= "\t%-5s --> %s\n".sprintf: $direction, @terms[ *-1 ];
    }

    my Real $sum = @terms.sum;

    ("\nThe minimum path from top to bottom: %s = %s\n\n\tMove      Element" ~
     "\n\t%s\n%s").printf: @terms.join(' + '), $sum, '-' x 17, $path;

    $sum == $triangle[ 0; 0 ]<SUM> or die 'Logic error';         # Sanity check
}

#------------------------------------------------------------------------------
sub get-array( Str:D $triangle --> Array:D[ Array:D[ Real:D ] ] )
#------------------------------------------------------------------------------
{
    $triangle ~~ / ^ \s* \[ \s* \[ \s* (.*?) \s* \] \s* \] \s* $ /
                                             or error( 'Invalid input array' );
    my Str         $string = $0.Str;
                   $string.chars > 0         or error( 'Empty array' );
    my Str         @rows = $string.split: / \] \, \s+ \[ /;
    my Array[Real] @triangle;

    try
    {
       @triangle = @rows.map:
              { Array[Real].new( .split( ',', :skip-empty ).map: { .Real } ) };
    }

    $!               and error( 'Found an element that is not a real number' );

    for 0 .. @triangle.end -> UInt $row
    {
        my UInt $cols = @triangle[$row].elems;

        $cols == $row + 1
                or error( 'Expected %d column%s in row %d, found %d'.sprintf:
                           $row + 1, $row == 0 ?? '' !! 's', $row + 1, $cols );
    }

    return @triangle;
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

use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 196
=========================

TASK #2
-------
*Range List*

Submitted by: Mohammad S Anwar

You are given a sorted unique integer array, @array.

Write a script to find all possible Number Range i.e [x, y] represent range all
integers from x and y (both inclusive).

    Each subsequence of two or more contiguous integers

Example 1

  Input: @array = (1,3,4,5,7)
  Output: [3,5]

Example 2

  Input: @array = (1,2,3,6,7,9)
  Output: [1,3], [6,7]

Example 3

  Input: @array = (0,1,2,4,5,6,8,9)
  Output: [0,2], [4,6], [8,9]

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. If the first argument is negative, it must be preceded by "--" to distin-
   guish it from a command-line flag.

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 196, Task #2: Range List (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    *@array where array-is-valid( @array )      #= A list of 1 or more integers
)
#==============================================================================
{
    "Input:  \@array = (%s)\n".printf: @array.join: ',';

    my Array[Int] @ranges = find-ranges( @array );

    "Output: %s\n".printf:
       find-ranges( @array ).map( { '[' ~ @$_.join( ',' ) ~ ']' } ).join: ', ';
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub find-ranges( List:D[Int:D] $array --> List:D[List:D[Int:D]] )
#------------------------------------------------------------------------------
{
    my (Array[Int] @ranges, Int @range);

    for @$array -> Int $n
    {
        if @range.elems == 0       ||        # Start the first range
           $n == @range[ *-1 ] + 1           # Extend an existing range
        {
            @range.push: $n;
        }
        else                                 # Start a new range
        {
            # First, handle (either keep or discard) the previous range

            @ranges.push: @range.clone if @range.elems > 1;

            @range = $n;
        }
    }

    @ranges.push: @range if @range.elems > 1;          # Handle the final range

    @$_ = $_[ 0, *-1 ] for @ranges;    # Remove all middle elements from ranges

    return @ranges;
}

#------------------------------------------------------------------------------
sub array-is-valid( List:D[Int:D] $array --> Bool:D )
#------------------------------------------------------------------------------
{
    return False unless $array.elems >= 1;            # Array must not be empty

    my UInt %integers{Int};

    for @$array -> Int $n              # Test whether array elements are unique
    {
        return False if ++%integers{ $n } > 1;
    }

    my Int @sorted = $array.sort;      # Test whether array elements are sorted

    return @sorted ~~ $array;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) =
            $line.split: / \| /, $TEST-FIELDS;

        $input    ~~ s/ ^ \s* (.+) \s* $ /$0/;                # Trim whitespace
        $expected ~~ s/ ^ \s* (.+) \s* $ /$0/;

        my Int        @array  = $input .split( / \s+ /, :skip-empty )
                                       .map: { .Int };
        my Array[Int] @ranges = find-ranges( @array );
        my Str        $got    = @ranges.map( { '[' ~ join( ',', @$_ ) ~ ']' } )
                                       .join: ', ';

        is $got, $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1| 1  3  4 5 7      |[3,5]
        Example 2| 1  2  3 6 7 9    |[1,3], [6,7]
        Example 3| 0  1  2 4 5 6 8 9|[0,2], [4,6], [8,9]
        Negatives|-3 -2 -1 1 2 5 6  |[-3,-1], [1,2], [5,6]
        END
}

###############################################################################

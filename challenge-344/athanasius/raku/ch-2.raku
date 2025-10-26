use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 344
=========================

TASK #2
-------
*Array Formation*

Submitted by: Mohammad Sajid Anwar

You are given two list: @source and @target.

Write a script to see if you can build the exact @target by putting these
smaller lists from @source together in some order. You cannot break apart or
change the order inside any of the smaller lists in @source.

Example 1

  Input: @source = ([2,3], [1], [4])
         @target = (1, 2, 3, 4)
  Output: true

  Use in the order: [1], [2,3], [4]

Example 2

  Input: @source = ([1,3], [2,4])
         @target = (1, 2, 3, 4)
  Output: false

Example 3

  Input: @source = ([9,1], [5,8], [2])
         @target = (5, 8, 2, 9, 1)
  Output: true

  Use in the order: [5,8], [2], [9,1]

Example 4

  Input: @source = ([1], [3])
         @target = (1, 2, 3)
  Output: false

  Missing number: 2

Example 5

  Input: @source = ([7,4,6])
         @target = (7, 4, 6)
  Output: true

  Use in the order: [7, 4, 6]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The elements of @source and @target may be any strings.
2. It must be possible to construct the target using elements from the source,
   but there may be elements of @source which are not used in building @target.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line. The first (the source) comprises
   a non-empty list of non-empty, square-bracket-delimited lists of strings,
   e.g., "[2,3], [1], [4]". The second (the target) comprises a non-empty list
   of strings, e.g., "1, 2, 3, 4". List elements are separated by commas and/or
   whitespace.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 344, Task #2: Array Formation (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $source,       #= Non-empty list of bracket-delimited lists of strings
    Str:D $target        #= Non-empty list of strings
)
#===============================================================================
{
    my (Array[Array[Str]] $source-array,
        Array[Str]        $target-array) = parse-input( $source, $target );

    "Input:  \@source = (%s)\n".printf: 
        $source-array.map( { '[' ~ join( ',', @$_ ) ~ ']' } ).join: ', ';

    "        \@target = (%s)\n".printf: $target-array.join: ', ';

    my Array[Str] @formation = find-array-formation( $source-array,
                                                     $target-array );

    if @formation.elems == 0
    {
        'Output: false'.put;
    }
    else
    {
        "Output: true\n\nUse in the order: %s\n".printf:
            @formation.map( { '[' ~ join( ',', @$_ ) ~ ']' } ).join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-array-formation
(
    List:D[List:D[Str:D]] $source where { .elems > 0 && .all.elems > 0 },
           List:D[Str:D]  $target where { .elems > 0 }
--> List:D[List:D[Str:D]]
)
#-------------------------------------------------------------------------------
{
    my Str        @source-strs = $source.map: { join '', @$_ };
    my Str        $target-str  = $target.join: '';
    my Array[Str] @formation;
    my UInt       @indices;

    if recursive-search( @source-strs, $target-str, @indices )
    {
        @formation.push: $source[$_] for @indices;
    }

    return @formation;
}

#-------------------------------------------------------------------------------
sub recursive-search
(
    List:D[Str:D]  $source,
    Str:D          $target,
    List:D[UInt:D] $indices
--> Bool:D
)
#-------------------------------------------------------------------------------
{
    return True if $target eq '';

    for 0 .. $source.end -> UInt $i
    {
        my Str $src = $source[$i];

        next unless $src.defined;

        if $target ~~ / ^ $src .* /
        {
            my Str $new-target     = $target.substr: $src.chars;
            my Str @new-source     = $source.clone;
                   @new-source[$i] = Nil;

            if recursive-search( @new-source, $new-target, $indices )
            {
                $indices.unshift: $i;

                return True;
            }
        }
    }

    return False;
}

#-------------------------------------------------------------------------------
sub parse-input( Str:D $source-str, Str:D $target-str --> List:D )
#-------------------------------------------------------------------------------
{
    # Note: characters not contained within square brackets are silently ignored

    my Array[Str] @source;
    my Match      @matches = $source-str ~~ m:g/ \[ (.*?) \] /;

    for @matches -> Match $match
    {
        @source.push: Array[Str].new: (~$match[0]).split: / <[ \s , ]>+ /;
    }

    @source.elems  > 0 or error( 'The source list is empty' );

    for @source -> Array[Str] $src
    {
        $src.elems > 0 or error( 'Empty source list element' );
    }

    my Str @target = $target-str.split: / <[ \s , ]>+ /;

    @target.elems  > 0 or error( 'The target list is empty' );

    return @source, @target;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $source-str, $target-str, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $source-str, $target-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my (Array[Array[Str]] $source, Array[Str] $target) =
                      parse-input( $source-str, $target-str );
        my Array[Str] @formation = find-array-formation( $source, $target );
        my Array[Str] @expected;
        my Match      @matches   = $expected-str ~~ m:g/ \[ (.*?) \] /;

        for @matches -> Match $match
        {
            @expected.push: Array[Str].new: (~$match[0]).split: / <[ \s , ]>+ /;
        }

        is-deeply @formation, @expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|[2 3] [1] [4]                     |1 2 3 4  |[1] [2 3] [4]
        Example 2|[1 3] [2 4]                       |1 2 3 4  |
        Example 3|[9 1] [5 8] [2]                   |5 8 2 9 1|[5 8] [2] [9 1]
        Example 4|[1] [3]                           |1 2 3    |
        Example 5|[7 4 6]                           |7 4 6    |[7 4 6]
        Surplus  |[2] [x y z] [9 1] [5 2] [5 8] [jk]|5 8 2 9 1|[5 8] [2] [9 1]
        END
}

################################################################################

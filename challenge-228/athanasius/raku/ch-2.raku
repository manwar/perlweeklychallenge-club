use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 228
=========================

TASK #2
-------
*Empty Array*

Submitted by: Mohammad S Anwar

You are given an array of integers in which all elements are unique.

Write a script to perform the following operations until the array is empty and
return the total count of operations.

    If the first element is the smallest then remove it otherwise move it to the
    end.

Example 1

  Input: @int = (3, 4, 2)
  Output: 5

  Operation 1: move 3 to the end: (4, 2, 3)
  Operation 2: move 4 to the end: (2, 3, 4)
  Operation 3: remove element 2: (3, 4)
  Operation 4: remove element 3: (4)
  Operation 5: remove element 4: ()

Example 2

  Input: @int = (1, 2, 3)
  Output: 3

  Operation 1: remove element 1: (2, 3)
  Operation 2: remove element 2: (3)
  Operation 3: remove element 3: ()

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If the first argument is negative, it must be preceded by '--' on the command
   line.
3. If $VERBOSE is set to True, the solution is followed by details of the opera-
   tions performed.

=end comment
#===============================================================================

use Test;

my Bool constant $VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 228, Task #2: Empty Array (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of unique integers

    *@int where { .elems > 0 && .all ~~ Int:D && are-unique( @int ) }
)
#===============================================================================
{
    "Input:  \@int = (%s)\n".printf: @int.join: ', ';

    my Str @ops = empty-array( @int );

    "Output: %d\n".printf: @ops.elems;

    if $VERBOSE
    {
        put();
       .put for @ops;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub empty-array( List:D[Int:D] $ints --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Int @int = @$ints;       # Make a copy
    my Str @ops;

    loop (my UInt $count = 1; @int.elems > 0; ++$count)
    {
        my Int $min =  @int.min;
        my Int $n   =  @int.shift;
        my Str $op  = "Operation $count: ";

        if $n == $min
        {
            $op ~= "remove element $n";
        }
        else
        {
            @int.push: $n;

            $op ~= "move $n to the end";
        }

        $op ~= ': (%s)'.sprintf: @int.join: ', ';

        @ops.push: $op;
    }

    return @ops;
}

#-------------------------------------------------------------------------------
sub are-unique( List:D[Int:D] $ints --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt %count{Int};

    ++%count{ $_ } for @$ints;

    $_ > 1 and return False for %count.values;

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $expected) = $line.split: / \| /;

        for     $test-name, $int-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @int = $int-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Str @ops = empty-array( @int );

        is @ops.elems, $expected.Int, $test-name;
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
        Example 1|      3 4 2| 5
        Example 2|      1 2 3| 3
        Reversed |6 5 4 3 2 1|21
        Singleton|         42| 1
        Negatives|-1 -2 -3 -4|10
        END
}

################################################################################

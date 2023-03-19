use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 208
=========================

TASK #2
-------
*Duplicate and Missing*

Submitted by: Mohammad S Anwar

You are given an array of integers in sequence with one missing and one dupli-
cate.

Write a script to find the duplicate and missing integer in the given array.
Return -1 if none found.

For the sake of this task, let us assume the array contains no more than one
duplicate and missing.

Example 1:

  Input: @nums = (1,2,2,4)
  Output: (2,3)

  Duplicate is 2 and Missing is 3.

Example 2:

  Input: @nums = (1,2,3,4)
  Output: -1

  No duplicate and missing found.

Example 3:

  Input: @nums = (1,2,3,3)
  Output: (3,4)

  Duplicate is 3 and Missing is 4.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Error Handling
--------------
1. Input errors abort the script with a Usage message. The following are input
   errors:
    - an element in the input array is not a valid integer
    - the input array is not sorted in monotonically increasing order.

2. Sequence errors produce an output of "-1". If $VERBOSE is set to True, an
   error message is also printed (immediately before the output). The following
   are sequence errors:
    - an element is duplicated more than once
    - more than one element is duplicated
    - there is a gap in the sequence of more than one integer
    - there is more than one gap in the sequence.

   If no duplicates are found, this is not an error, but since the output is -1,
   an explanatory note is printed if $VERBOSE is True.

=end comment
#===============================================================================

use Test;

my Bool constant $VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 208, Task #2: Duplicate and Missing (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| An ordered list of integers

    *@nums where { .elems > 0 && .all ~~ Int:D && is-ordered( @nums ) }
)
#===============================================================================
{
    "Input:  \@nums = (%s)\n".printf: @nums.join: ',';

    my (UInt $dups,
        Int  $elem)  = find-duplicates( @nums );
    my  Str  $output = '-1';

    if $dups > 0
    {
        my Int $missing = find-missing( @nums );
               $output  = $missing.defined ?? "($elem,$missing)" !! '-1';
    }
    elsif $VERBOSE
    {
        'Note:   No duplicate found'.note;
    }

    "Output: $output".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-duplicates( List:D[Int:D] $nums --> List:D[ UInt:D, Int ] )
#-------------------------------------------------------------------------------
{
    my Int %counts{ UInt };
    my Int @dups;

    ++%counts{ $_ } for @$nums;

    for %counts.keys.sort -> $num
    {
        my UInt $count = %counts{ $num };

        if    $count >  2
        {
            seq-error( qq["$num" is duplicated more than once] );
            return;
        }
        elsif $count == 2
        {
            @dups.push: $num;
        }
    }

    my UInt $dups = @dups.elems;

    if $dups > 1
    {
        seq-error( 'More than one integer is duplicated' );
        return;
    }

    return $dups, $dups == 0 ?? Int !! @dups[ 0 ];
}

#-------------------------------------------------------------------------------
sub find-missing( List:D[Int:D] $nums --> Int )
#-------------------------------------------------------------------------------
{
    my Int  $elem  = $nums[ 0 ];
    my UInt $count = 0;
    my Int  $missing;

    for 1 .. $nums.end -> UInt $i
    {
        my Int  $next = $nums[ $i ];
        my UInt $diff = $next - $elem;

        if    $diff >  2
        {
            seq-error( "More than one integer is missing between $elem and " ~
                       "and $next" );
            return;
        }
        elsif $diff == 2
        {
            $missing = $elem + 1;
            ++$count;
        }

        $elem = $next;
    }

    if $count > 1
    {
        seq-error( 'There is more than one gap in the sequence' );
        return;
    }

    return $missing // $nums[ *-1 ] + 1;
}

#-------------------------------------------------------------------------------
sub is-ordered( List:D[Int:D] $nums --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Int $elem = $nums[ 0 ];

    for 1 .. $nums.end -> UInt $i
    {
        my Int $next = $nums[ $i ];

        $elem <= $next or return False;
        $elem  = $next;
    }

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) = $line.split: / \| /;

        my  Int  @nums  = $input.split( / \, / ).map: { .Int };
        my (UInt $dups,
            Int  $elem) = find-duplicates( @nums );
        my  Str  $got   = '-1';

        if $dups
        {
            my Int $missing = find-missing( @nums );
                   $got     = "$elem,$missing";
        }

        is $got, $expected, $test-name;
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
sub seq-error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "Error:  $message".note if $VERBOSE;
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
        Example 1|1,2,2,4|2,3
        Example 2|1,2,3,4|-1
        Example 3|1,2,3,3|3,4
        END
}

################################################################################

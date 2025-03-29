use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 314
=========================

TASK #2
-------
*Sort Column*

Submitted by: Mohammad Sajid Anwar

You are given a list of strings of same length.

Write a script to make each column sorted lexicographically by deleting any non
sorted columns.

Return the total columns deleted.

Example 1

  Input: @list = ("swpc", "tyad", "azbe")
  Output: 2

  swpc
  tyad
  azbe

  Column 1: "s", "t", "a" => non sorted
  Column 2: "w", "y", "z" => sorted
  Column 3: "p", "a", "b" => non sorted
  Column 4: "c", "d", "e" => sorted

  Total columns to delete to make it sorted lexicographically.

Example 2

  Input: @list = ("cba", "daf", "ghi")
  Output: 1

Example 3

  Input: @list = ("a", "b", "c")
  Output: 0

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of same-length strings is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 314, Task #2: Sort Column (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of same-length strings

    *@list where { .elems > 0 && .all.chars == @list[ 0 ].chars }
)
#===============================================================================
{
    "Input:  \@list = (%s)\n".printf: @list.map( { qq["$_"] } ).join: ', ';

    my UInt $deleted = count-deleted-columns( @list );

    "Output: $deleted".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-deleted-columns( List:D[Str:D] $list --> UInt:D )
#-------------------------------------------------------------------------------
{
    $list.elems > 0                     or error( 'Empty list'  );
    $list.all.chars == $list[ 0 ].chars or error( 'Ragged list' );

    my UInt $deleted = 0;
    my Str  @columns;

    for @$list -> Str $str
    {
        my Str @chars = $str.split: '', :skip-empty;

        @columns[ $_ ] ~= @chars[ $_ ] for 0 .. @chars.end;
    }

    ++$deleted unless is-sorted( $_ ) for @columns;

    return $deleted;
}

#-------------------------------------------------------------------------------
sub is-sorted( Str:D $string --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Str @chars  = $string.split: '', :skip-empty;
    my Str @sorted = @chars\.sort;
    my Str $sorted = @sorted.join;

    return $string eq $sorted;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $list-str, $expected) = $line.split: / \| /;

        for     $test-name, $list-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @list    = $list-str.split: / \s+ /, :skip-empty;
        my UInt $deleted = count-deleted-columns( @list );

        is $deleted, $expected.Int, $test-name;
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
        Example 1  |swpc  tyad  azbe |2
        Example 2  |cba   daf   ghi  |1
        Example 3  |a     b     c    |0
        All deleted|fghij abcde vwxyz|5
        END
}

################################################################################

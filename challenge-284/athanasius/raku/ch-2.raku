use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 284
=========================

TASK #2
-------
*Relative Sort*

Submitted by: Mohammad Sajid Anwar

You are given two list of integers, @list1 and @list2. The elements in the
@list2 are distinct and also in the @list1.

Write a script to sort the elements in the @list1 such that the relative order
of items in @list1 is same as in the @list2. Elements that is missing in @list2
should be placed at the end of @list1 in ascending order.

Example 1

  Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
         @list2 = (2, 1, 4, 3, 5, 6)
  Output: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)

Example 2

  Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
         @list2 = (1, 3, 2)
  Output: (1, 3, 3, 3, 2, 2, 4, 4, 6)

Example 3

  Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
         @list2 = (1, 0, 3, 2)
  Output: (1, 1, 1, 0, 0, 3, 2, 4, 5)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line. Each string contains a list of
   integers separated by whitespace. The integers in the second list are unique
   within that list, and each is also an element of the first list.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 284, Task #2: Relative Sort (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $list1,    #= String of whitespace-separated integers
    Str:D $list2     #= String of whitespace-separated distinct integers also in
                     #= list1
)
#===============================================================================
{
    my Array[Int] @lists = parse-command-line( $list1, $list2 );

    my Int (@list1, @list2) := @lists;            # ":=" is the binding operator

    "Input: \@list1 = (%s)\n".printf: @list1.join: ', ';
    "       \@list2 = (%s)\n".printf: @list2.join: ', ';

    my Int @sorted = relative-sort( @list1, @list2 );

    "Output:         (%s)\n".printf: @sorted.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub relative-sort
(
    List:D[Int:D] $list1,
    List:D[Int:D] $list2
--> List:D[Int:D]
)
#-------------------------------------------------------------------------------
{
    my Int (@sorted, @missing);
    my UInt %dict{Int};

    for @$list1 -> Int $n
    {
        if $n ∈ $list2
        {
            ++%dict{ $n };
        }
        else
        {
            @missing.push: $n;
        }
    }

    for @$list2 -> Int $m
    {
        @sorted.push( $m ) for ^%dict{ $m };
    }

    @sorted.append: @missing.sort;            # Note: append() flattens the list

    return @sorted;
}

#-------------------------------------------------------------------------------
sub parse-command-line
(
    Str:D $list1,
    Str:D $list2
--> List:D[ List:D[Int:D], List:D[Int:D] ]
)
#-------------------------------------------------------------------------------
{
    my Int (@list1, @list2);

    for $list1.split: / \s+ /, :skip-empty -> Str $s
    {
        +$s ~~ Int:D or error( qq["$s" is not a valid integer] );
        @list1.push: +$s;
    }

    my UInt %dict1{Int};
          ++%dict1{ $_ } for @list1;

    for $list2.split: / \s+ /, :skip-empty -> Str $t
    {
        +$t ~~ Int:D or error( qq["$t" is not a valid integer] );
        @list2.push: +$t;
    }

    my UInt %dict2{Int};
          ++%dict2{ $_ } for @list2;

    for @list2 -> Int $n
    {
        %dict2{ $n } == 1   or error( "Element $n is not unique in \@list2"  );
        %dict1{ $n }:exists or error( "\@list2 element $n is not in \@list1" );
    }

    return @list1, @list2;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $list1-str, $list2-str, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $list1-str, $list2-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @list1    = str-to-ints( $list1-str );
        my Int @list2    = str-to-ints( $list2-str );
        my Int @expected = str-to-ints( $expected-str );
        my Int @sorted   = relative-sort( @list1, @list2 );

        is-deeply @sorted, @expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub str-to-ints( Str:D $string --> Seq:D[Int:D] )
#-------------------------------------------------------------------------------
{
    return $string.split( / \s+ /, :skip-empty ).map: { .Int };
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
        Example 1|2 3 9 3 1 4 6 7 2 8 5|2 1 4 3 5 6|2 2 1 4 3 3 5 6 7 8 9
        Example 2|3 3 4 6 2 4 2 1 3    |1 3 2      |1 3 3 3 2 2 4 4 6
        Example 3|3 0 5 0 2 1 4 1 1    |1 0 3 2    |1 1 1 0 0 3 2 4 5
        END
}

################################################################################

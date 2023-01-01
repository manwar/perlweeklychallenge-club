use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 197
=========================

TASK #2
-------
*Wiggle Sort*

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to perform Wiggle Sort on the given list.


    Wiggle sort would be such as list[0] < list[1] > list[2] < list[3]….


Example 1

  Input: @list = (1,5,1,1,6,4)
  Output: (1,6,1,5,1,4)

Example 2

  Input: @list = (1,3,2,2,3,1)
  Output: (2,3,1,3,1,2)

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. If the first argument is negative, it must be preceded by "--" to distin-
   guish it from a command-line flag.

Notes
-----
1. 'Wiggle sort' is also known as 'wave sort'.
2. If no solution is possible for a given input, the output is '()', which
   represents the empty list.
3. The solution algorithm is described in [1].
4. The algorithm for determining whether a given input list is wiggle-sortable
   (by counting "medians") is given in [1], corrected in [2].

References
----------
[1] John L., Answer to "How to wiggle sort an array in linear time complex-
    ity?", Computer Science Stack Exchange (8 May, 2020), https://cs.stack
    exchange.com/questions/125372/how-to-wiggle-sort-an-array-in-linear-time-
    complexity

[2] John L, Answer to "How to find wiggle sortable arrays? Did I misunderstand
    John L.s' answer?" Computer Science Stack Exchange (25 April, 2022),
    https://cs.stackexchange.com/questions/150886/how-to-find-wiggle-sortable-
    arrays-did-i-misunderstand-john-l-s-answer

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 197, Task #2: Wiggle Sort (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of 1 or more integers

    *@list where { .elems >= 1 && .all ~~ Int:D }
)
#==============================================================================
{
    "Input:  \@list = (%s)\n".printf:              @list  .join: ', ';

    "Output:         (%s)\n" .printf: wiggle-sort( @list ).join: ', ';
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub wiggle-sort( List:D[Int:D] $list --> List:D[Int:D] )
#------------------------------------------------------------------------------
{
    my Int @list = @$list;
    my Int @sorted;

    if is-wiggle-sortable( @list )
    {
        @list.=sort;

        my UInt $max-i = @list.end;

        for 1 .. $max-i -> UInt $i
        {
            next  if $i %% 2;
            @sorted[ $i ] = @list.pop;
        }

        for 0 .. $max-i -> UInt $j
        {
            next  if $j % 2 == 1;
            @sorted[ $j ] = @list.pop;
        }

        is-wiggle-sorted( @sorted ) or die 'Wiggle sort failed';
    }

    return @sorted;
}

#------------------------------------------------------------------------------
sub is-wiggle-sortable( List:D[Int:D] $list --> Bool:D )
#------------------------------------------------------------------------------
{
    # Count "medians" (see [1] as corrected in [2])

    my Int  @sorted = $list.sort;               # 1. Sort the list
    my UInt $n      = @sorted.elems;            # 2. Find m, the ⌈n/2⌉-th entry
    my UInt $n2     = ($n / 2).ceiling;
    my Int  $m      = @sorted[ $n2 - 1 ];
    my UInt $count  = 0;                        # 3. Count entries equal to m
    $_ == $m && ++$count for @sorted;

    # 4. "The number of medians of A is no more than ⌈n/2⌉. Furthermore, if n
    #     is odd and the number of medians is ⌈n/2⌉, the median must be the
    #     smallest number of A." -- [2], with typo corrected

    return ($count > $n2) ?? False !!
           ($count < $n2) ?? True  !!
           ($n % 2 == 1)  ?? ($m == @sorted[ 0 ]) !! True;
}

#------------------------------------------------------------------------------
sub is-wiggle-sorted( List:D[Int:D] $list --> Bool:D )
#------------------------------------------------------------------------------
{
    for 0 .. $list.end - 1 -> UInt $i
    {
        if $i %% 2
        {
            return False unless $list[ $i ] < $list[ $i + 1 ];
        }
        else
        {
            return False unless $list[ $i ] > $list[ $i + 1 ];
        }
    }

    return True;
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

        s/ ^ \s* (.+?) \s* $ /$0/                             # Trim whitespace
            for $test-name, $input, $expected;

        my Int @list   = $input.split( / \, /, :skip-empty ).map: { .Int };
        my Int @sorted = wiggle-sort( @list );
        my Str $got    = @sorted.join: ',';

        ok( is-wiggle-sorted( @sorted ), $test-name ) if $expected;
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
        Example 1   |1,5,1,1,6,4|1,6,1,5,1,4
        Example 2   |1,3,2,2,3,1|2,3,1,3,1,2
        Short       |2,1,1      |1,2,1
        Not sortable|1,2,2      |
        Distinct    |5,4,3,2,1,0|2,5,1,4,0,3
        Single      |42         |42
        Negatives   |-1,-2,-3,-4|-3,-1,-4,-2
        END
}

###############################################################################

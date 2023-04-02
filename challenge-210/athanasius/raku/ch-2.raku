use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 210
=========================

TASK #2
-------
*Number Collision*

Submitted by: Mohammad S Anwar

You are given an array of integers which can move in right direction if it is
positive and left direction when negative. If two numbers collide then the
smaller one will explode. And if both are same then they both explode. We take
the absolute value in consideration when comparing.

All numbers move at the same speed, therefore any 2 numbers moving in the same
direction will never collide.

Write a script to find out who survives the collision.

Example 1:

  Input: @list = (2, 3, -1)
  Output: (2, 3)

  The numbers 3 and -1 collide and -1 explodes in the end. So we are left with
  (2, 3).

Example 2:

  Input: @list = (3, 2, -4)
  Output: (-4)

  The numbers 2 and -4 collide and 2 explodes in the end. That gives us (3, -4).
  Now the numbers 3 and -4 collide and 3 explodes. Finally we are left with -4.

Example 3:

  Input: @list = (1, -1)
  Output: ()

  The numbers 1 and -1 both collide and explode. Nothing left in the end.

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

Assumptions
-----------
1. All movement occurs in a single dimension.
2. The order in which the integers appear in the array is the same (left-to-
   right) order in which they are arranged, relative to each other, in one-
   dimensional space.
3. A value of 0 (zero) is unmoving. (And, of course, if anything collides with a
   0, the 0 explodes.)

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 210, Task #2: Number Collision (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@list where { .elems > 0 && .all ~~ Int:D }           #= A list of integers
)
#===============================================================================
{
    "Input:  \@list = (%s)\n".printf: @list.join: ', ';

    my @survivors = find-survivors( @list );

    "Output: (%s)\n".printf: @survivors.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-survivors( Int:D @list --> Seq:D[Int:D] )
#-------------------------------------------------------------------------------
{
    my Int  @middle = @list;
    my Int (@left,    @right);

    while has-non-zero( @middle )
    {
        @left.push:     @middle.shift
            while @middle[   0 ].defined && @middle[   0 ] < 0;

        @right.unshift: @middle.pop
            while @middle[ *-1 ].defined && @middle[ *-1 ] > 0;

        my Int @next = Int xx @middle.elems;

        move-left\( @middle, @next );
        move-right( @middle, @next );

        @middle = @next;
    }

    my Int @survivors =       |@left;
           @survivors.append: |@middle, |@right;

    return @survivors.grep: { .defined };
}

#-------------------------------------------------------------------------------
sub move-left( List:D[Int] $middle, List:D[Int] $next )
#-------------------------------------------------------------------------------
{
    for 0 .. $middle.end -> UInt $i
    {
        if (my Int $elem0 = $middle[ $i ]).defined
        {
            if    $elem0 == 0       # Unmoving
            {
                $next[ $i ] = 0;
            }
            elsif $elem0 <  0       # Moving left
            {
                if (my Int $elem1 = $middle[ $i - 1 ]).defined
                {
                    if    $elem0.abs >  $elem1
                    {
                        $middle[ $i - 1 ] = Int;
                        $next\ [ $i - 1 ] = $elem0;
                    }
                    elsif $elem0.abs == $elem1
                    {
                        $middle[ $i - 1 ] = Int;
                    }
                }
                else
                {
                    $middle[ $i - 1 ] = Int;
                    $next\ [ $i - 1 ] = $elem0;
                }
            }
        }
    }
}

#-------------------------------------------------------------------------------
sub move-right( List:D[Int] $middle, List:D[Int] $next )
#-------------------------------------------------------------------------------
{
    for (0 .. $middle.end).reverse -> UInt $i
    {
        my Int $elem0 = $middle[ $i ];

        if $elem0.defined && $elem0 > 0     # Moving right
        {
            if (my Int $elem1 = $next[ $i + 1 ]).defined
            {
                if    $elem0 == $elem1.abs
                {
                    $next[ $i + 1 ] = Int;
                }
                elsif $elem0 >  $elem1.abs
                {
                    $next[ $i + 1 ] = $elem0;
                }
            }
            else
            {
                $next[ $i + 1 ] = $elem0;
            }
        }
    }
}

#-------------------------------------------------------------------------------
sub has-non-zero( List:D[Int:D] $list --> Bool:D )
#-------------------------------------------------------------------------------
{
    for @$list
    {
        return True if .defined && .abs > 0;
    }

    return False;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $output) = $line.split: / \| /;

        $input     ~~ s/ ^ \s+   //;         # Trim whitespace
        $input     ~~ s/   \s+ $ //;
        $output    ~~ s/ ^ \s+   //;
        $output    ~~ s/   \s+ $ //;
        $test-name ~~ s/   \s+ $ //;

        my Int @list     = $input.split(  / \, \s* / ).map: { .Int };
        my Int @got      = find-survivors( @list )\   .map: { .Int };
        my Int @expected = $output.split( / \, \s* /, :skip-empty )\
                                                      .map: { .Int };
        is-deeply @got, @expected, $test-name;
    }

    done-testing;
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
        Example 1         | 2,  3, -1             | 2, 3
        Example 2         | 3,  2, -4             |-4
        Example 3         | 1, -1                 |
        No collision      |-2,  1                 |-2, 1
        Adjacent collision| 2, -3                 |-3
        Meet in the middle| 4,  0, -3             | 4
        Combination       |-7,  2, -3, 4, 0, -3, 8|-7, -3, 4, 8
        END
}

################################################################################

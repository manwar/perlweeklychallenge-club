use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 109
=========================

TASK #2
-------
*Four Squares Puzzle*

Submitted by: Mohammad S Anwar

You are given four squares as below with numbers named a,b,c,d,e,f,g.

              (1)                    (3)
        ╔══════════════╗      ╔══════════════╗
        ║              ║      ║              ║
        ║      a       ║      ║      e       ║
        ║              ║ (2)  ║              ║  (4)
        ║          ┌───╫──────╫───┐      ┌───╫─────────┐
        ║          │   ║      ║   │      │   ║         │
        ║          │ b ║      ║ d │      │ f ║         │
        ║          │   ║      ║   │      │   ║         │
        ║          │   ║      ║   │      │   ║         │
        ╚══════════╪═══╝      ╚═══╪══════╪═══╝         │
                   │       c      │      │      g      │
                   │              │      │             │
                   │              │      │             │
                   └──────────────┘      └─────────────┘

Write a script to place the given unique numbers in the square box so that sum
of numbers in each box is the same.

Example

 Input: 1,2,3,4,5,6,7

 Output:

     a = 6
     b = 4
     c = 1
     d = 5
     e = 2
     f = 3
     g = 7

     Box 1: a + b = 6 + 4 = 10
     Box 2: b + c + d = 4 + 1 + 5 = 10
     Box 3: d + e + f = 5 + 2 + 3 = 10
     Box 4: f + g = 3 + 7 = 10

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
A sequence of 7 unique numbers can be arranged in 7! = 5040 different ways. For
a computer, that is a small search space; therefore, the algorithm used is a
simple search.

Note that a given input of 7 numbers may produce zero solutions, or many:

    Input                               Solutions
     1,   2, 3,   4, 5,   6,  7             8
     1,   2, 3,   4, 5,   6, 17             0
    -1.5, 0, 1.5, 3, 4.5, 6,  7.5          10

=end comment
#==============================================================================

my UInt constant $ARGUMENTS = 7;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 109, Task #2: Four Squares Puzzle (Raku)\n".put;
}

#==============================================================================
multi sub MAIN()                                             #= Default: 1 .. 7
#==============================================================================
{
    my Real @numbers = 1 .. $ARGUMENTS;

    place-numbers( @numbers );
}

#==============================================================================
multi sub MAIN
(
    #| A list of 7 unique real numbers

    *@numbers where { .all ~~ Real:D && @numbers.unique.elems == $ARGUMENTS }
)
#==============================================================================
{
    my Real @reals = @numbers.map: { .Real };

    place-numbers( @reals );
}

#------------------------------------------------------------------------------
sub place-numbers( Array:D[Real:D] $numbers )
#------------------------------------------------------------------------------
{
    "Input: %s\n\nOutput:\n\n".printf: $numbers.join: ', ';

    my UInt $solutions = 0;

    for permutations @$numbers.sort -> List $permutation
    {
        my Real ($a, $b, $c, $d, $e, $f, $g) = @$permutation;
        my Real  $box1 = $a + $b;

        next unless $b + $c + $d == $box1 &&
                    $d + $e + $f == $box1 &&
                    $f + $g      == $box1;

        ++$solutions;

        ("  Solution $solutions: a = $a, b = $b, c = $c, d = $d, e = $e, " ~
         "f = $f, g = $g\n    Each box sums to $box1\n").put;
    }

    "  %s solution%s found\n".printf: $solutions == 0 ?? 'No' !! $solutions,
                                      $solutions == 1 ?? ''   !! 's';
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################

use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 346
=========================

TASK #2
-------
*Magic Expression*

Submitted by: Mohammad Sajid Anwar

You are given a string containing only digits and a target integer.

Write a script to insert binary operators +, - and * between the digits in the
given string that evaluates to target integer.

Example 1

  Input: $str = "123", $target = 6
  Output: ("1*2*3", "1+2+3")

Example 2

  Input: $str = "105", $target = 5
  Output: ("1*0+5", "10-5")

Example 3

  Input: $str = "232", $target = 8
  Output: ("2*3+2", "2+3*2")

Example 4

  Input: $str = "1234", $target = 10
  Output: ("1*2*3+4", "1+2+3+4")

Example 5

  Input: $str = "1001", $target = 2
  Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")

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
2. A string containing only digits is entered on the command-line, followed by
   and integer.

=end comment
#===============================================================================

use Test;

my constant @OPS = |< * + - >, '';

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 346, Task #2: Magic Expression (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str where { / ^ <[0..9]>* $ / },   #= A string containing only digits
    Int:D $target                             #= A target integer
)
#===============================================================================
{
    qq[Input:  \$str = "$str", \$target = $target].put;

    my Str @expressions = find-magic-expressions( $str, $target );

    "Output: (%s)\n".printf: @expressions.map( { qq["$_"] } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-magic-expressions
(
    Str:D $str where { / ^ <[0..9]>* $ / },
    Int:D $target
--> List:D[Str:D]
)
#-------------------------------------------------------------------------------
{
    my Str  @expressions;
    my UInt $length-str = $str.chars;

    if    $length-str == 0
    {
      # @expressions is already empty;
    }
    elsif $length-str == 1
    {
        @expressions.push: $str == $target ?? $str !! ();
    }
    else
    {
        my UInt @stack = 0 xx ($length-str - 1);

        L-OUTER: loop (my UInt $level = @stack.end; ; $level = @stack.end)
        {
            my Str @chars = $str.split: '', :skip-empty;
            my Str $exp   = @chars[0];
                   $exp  ~= @OPS[ @stack[$_] ] ~ @chars[$_ + 1]
                                                            for 0 .. @stack.end;

            # Discard any "solution" in which 2+ digits begin with a zero

            @expressions.push: $exp if $exp !~~ /0\d/ && $target == EVAL $exp;

            while (++@stack[ $level ] > @OPS.end)
            {
                last L-OUTER if $level == 0;

                @stack[ $level-- ] = 0;
            }
        }
    }

    return @expressions;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $target, $exp-str) = $line.split: / \| /;

        for     $test-name, $str, $target, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @expressions = find-magic-expressions( $str, $target.Int );
        my Str @expected    = $exp-str.split: / \s+ /, :skip-empty;

        is-deeply @expressions, @expected, $test-name;
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
        Example 1| 123| 6|  1*2*3   1+2+3
        Example 2| 105| 5|  1*0+5    10-5
        Example 3| 232| 8|  2*3+2   2+3*2
        Example 4|1234|10|1*2*3+4 1+2+3+4
        Example 5|1001| 2|1+0*0+1 1+0+0+1 1+0-0+1 1-0*0+1 1-0+0+1 1-0-0+1
        END
}

################################################################################

use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 190
=========================

TASK #1
-------
*Capital Detection*

Submitted by: Mohammad S Anwar

You are given a string with alphabetic characters only: A..Z and a..z.

Write a script to find out if the usage of Capital is appropriate if it satis-
fies at least one of the following rules:

  1) Only first letter is capital and all others are small.
  2) Every letter is small.
  3) Every letter is capital.

Example 1

  Input: $s = 'Perl'
  Output: 1

Example 2

  Input: $s = 'TPF'
  Output: 1

Example 3

  Input: $s = 'PyThon'
  Output: 0

Example 4

  Input: $s = 'raku'
  Output: 1

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Observation
-----------
A single-letter string always satisfies either requirement 2 or requirement 3.

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 190, Task #1: Capital Detection (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A non-empty string of alphabetic characters (A-Z and a-z) only

    Str:D $s where { $s.chars > 0 && $s ~~ / ^ <[ a..z A..Z ]>+ $ / }
)
#==============================================================================
{
    "Input:  \$s = '$s'".put;
    "Output: %d\n".printf: capitals-are-valid( $s );
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub capitals-are-valid( Str:D $s --> UInt:D )
#------------------------------------------------------------------------------
{
    return 1 if $s.chars == 1;

    return 1 if $s ~~ / ^ <[a..z]>+ $ / ||      # 2) Every letter is small
                $s ~~ / ^ <[A..Z]>+ $ /;        # 3) Every letter is capital

    my Str $first = $s.substr: 0, 1;
    my Str $rest  = $s.substr: 1;

    # 1) Only first letter is capital and all others are small

    return 1 if so $first ~~ / ^ <[A..Z]>  $ / &&
                so $rest  ~~ / ^ <[a..z]>* $ /;

    return 0;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $s, $expected) =
            $line.split: / \, \s* /, $TEST-FIELDS;

        is capitals-are-valid( $s ), $expected.Int, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1, Perl,   1
        Example 2, TPF,    1
        Example 3, PyThon, 0
        Example 4, raku,   1
        Single,    X,      1
        END
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

###############################################################################

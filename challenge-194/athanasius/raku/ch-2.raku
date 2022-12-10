use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 194
=========================

TASK #2
-------
*Frequency Equalizer*

Submitted by: Mohammad S Anwar

You are given a string made of alphabetic characters only, a-z.

Write a script to determine whether removing only one character can make the
frequency of the remaining characters the same.

Example 1:

  Input: $s = 'abbc'
  Output: 1 since removing one alphabet 'b' will give us 'abc' where each
          alphabet frequency is the same.

Example 2:

  Input: $s = 'xyzyyxz'
  Output: 1 since removing 'y' will give us 'xzyyxz'.

Example 3:

  Input: $s = 'xzxz'
  Output: 0 since removing any one alphabet would not give us string with same
          frequency alphabet.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. To display the character (if any) whose removal can equalize the frequencies
   of the remaining characters, set $VERBOSE to True. (This has no effect on
   the running of the test suite.)

Corner Cases
------------
I assume that the empty string has "all characters the same", so a string of 1
character satisfies the Task requirement and should give output 1. (Of course,
the empty string itself has output 0 because it is not possible to remove a
character from it.)

A string of identical characters (of any number) likewise satisfies the Task
requirement, because removal of a single character leaves a string of identical
characters and -- since there is only one distinct character -- this leaves
"all remaining characters" with the "same" frequency.

The only case in which there is more than one way to satisfy the Task require-
ment is when the input string consists of exactly two different characters:
then either character may be removed to leave a single character with a fre-
quency of 1. In this case I arbitrarily choose to remove the first character.

=end comment
#==============================================================================

use Test;

subset S-type of Str where * ~~ / ^ <[ a .. z ]>* $ /;

my UInt constant $TST-FLDS = 3;
my Bool constant $VERBOSE  = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 194, Task #2: Frequency Equalizer (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    S-type:D $s      #= A string composed of lower case letters "a" to "z" only
)
#==============================================================================
{
    qq[Input:  \$s = "$s"].put;

    my Str $char = char2remove( $s );

    "Output: %d".printf: $char ?? 1 !! 0;
    qq[ (remove one letter "$char")].print if $VERBOSE && $char;
    put();
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub char2remove( S-type:D $s --> Str:D )
#------------------------------------------------------------------------------
{
    my UInt $len = $s.chars;

    return ''                if $len == 0;
    return $s                if $len == 1;
    return $s.substr( 0, 1 ) if $len == 2;

    my UInt %char2freq{Str};                                # Count frequencies
          ++%char2freq{ $_ } for $s.split: '', :skip-empty;

    my Array[Str] %freq2char{UInt};

    for %char2freq.kv -> Str $key, UInt $value              # Reverse the hash
    {
        %freq2char{ $value }.push: $key;
    }

    my UInt @keys   = %freq2char.keys;
    my UInt $n-keys = @keys.elems;

    return %freq2char{ @keys[ 0 ] }[ 0 ]
        if $n-keys == 1 && %freq2char{ @keys[ 0 ] }.elems == 1;

    return '' unless $n-keys == 2;

    my UInt ($low, $high) = @keys.sort;

    return '' unless %freq2char{ $high }.elems == 1;

    return ($high == $low + 1) ?? %freq2char{ $high }[ 0 ] !! '';
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $s, $expected) =
            $line.split: / \, \s* /, $TST-FLDS;

        my UInt $got = char2remove( $s ) ?? 1 !! 0;

        is $got, $expected.Int, $test-name;
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
        Example 1,      abbc,    1
        Example 2,      xyzyyxz, 1
        Example 3,      xzxz,    0
        Empty string,   ,        0
        Single letter,  j,       1
        Same letters 2, dd,      1
        Same letters 5, eeeee,   1
        Distinct pair,  ab,      1
        END
}

###############################################################################

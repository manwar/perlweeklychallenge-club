use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 249
=========================

TASK #2
-------
*DI String Match*

Submitted by: Mohammad S Anwar

You are given a string s, consisting of only the characters "D" and "I".

Find a permutation of the integers [0 .. length(s)] such that for each character
s[i] in the string:

  s[i] == 'I' ⇒ perm[i] < perm[i + 1]
  s[i] == 'D' ⇒ perm[i] > perm[i + 1]

Example 1

  Input: $str = "IDID"
  Output: (0, 4, 1, 3, 2)

Example 2

  Input: $str = "III"
  Output: (0, 1, 2, 3)

Example 3

  Input: $str = "DDI"
  Output: (3, 2, 0, 1)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. Command-line arguments:
     i. None: the test suite is run.
    ii. A non-empty string s consisting of only the characters "D" and/or "I":
        a solution is found for s.
   iii. A single integer n > 0: an input string s of n characters is randomly
        generated, then a solution is found for s.

2. If DEBUG is set to True, each solution is checked to verify that it satisfies
   the given criteria.

Algorithm
---------
Let s be the input string
    t be the tuple [0, 1, ..., length(s)]
    p be a permutation of t which satisfies the two given criteria for s.

1.  Partition t into x, y, z where
    -- x is a tuple of the smallest k elements of t where k is the count of "I"
       characters in s
    -- z is a tuple of the largest  m elements of t where m is the count of "D"
       characters in s
    -- y is the only element of t not already included in x or z
2.  Create an empty solution tuple p
3.  FOR i = 0 to length(s) - 1
        IF s[i] = "I" THEN
           p[i] := the smallest remaining element of x
           Remove that element from x
        ELSE
           p[i] := the largest  remaining element of z
           Remove that element from z
        ENDIF
    ENDFOR
4.  p[length(s)] := y
5.  Return p

=end comment
#===============================================================================

use Test;

my Bool constant DEBUG = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 249, Task #2: DI String Match (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Int:D $len where * > 0      #= Integer > 0: length of string to be generated
)
#===============================================================================
{
    my Str $str = '';

    for 1 .. $len
    {
        my $char = (^2).pick ?? 'D' !! 'I';

        $str ~= $char;
    }

    qq[Input:  \$str = "$str"].put;

    my UInt @permutation = DI-string-match( $str );

    if DEBUG && !verify( $str, @permutation )
    {
        die qq[Permutation (%s) for "%s" failed verification].sprintf:
              @permutation.join: ', ', $str;
    }

    "Output: (%s)\n".printf: @permutation.join: ', ';
}

#===============================================================================
multi sub MAIN
(
    #| Non-empty string consisting of only the characters "D" and "I"

    Str:D $str where / ^ <[DI]>+ $ /
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt @permutation = DI-string-match( $str );

    if DEBUG && !verify( $str, @permutation )
    {
        die qq[Permutation (%s) for "%s" failed verification].sprintf:
              @permutation.join: ', ', $str;
    }

    "Output: (%s)\n".printf: @permutation.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub DI-string-match( Str:D $str where / ^ <[DI]>+ $ / --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt @perm;
    my UInt $len  = $str.chars;
    my UInt @ints = 0  ..  $len;

    for 0 .. $len - 1 -> UInt $i
    {
        if $str.substr( $i, 1 ) eq 'D'
        {
            @perm[ $i ] = @ints.pop;
        }
        else
        {
            @perm[ $i ] = @ints.shift;
        }
    }

    @perm[ $len ] = @ints.shift;

    return @perm;
}

#-------------------------------------------------------------------------------
sub verify
(
    Str:D          $str  where / ^ <[DI]>+ $ /,
    List:D[UInt:D] $perm where $perm.elems == $str.chars + 1
--> Bool:D
)
#-------------------------------------------------------------------------------
{
    for 0 .. $str.chars - 1 -> UInt $i
    {
        my $first  = $perm[ $i     ];
        my $second = $perm[ $i + 1 ];

        if $str.substr( $i, 1 ) eq 'D'
        {
            return False unless $first > $second;
        }
        else    # 'I'
        {
            return False unless $first < $second;
        }
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
        my Str ($test-name, $str, $expected-str) = $line.split: / \| /;

        for     $test-name, $str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @permutation = DI-string-match( $str );
        my UInt @expected    = $expected-str.split( / \s+ / ).map: { .Int };

        is-deeply @permutation, @expected, "$test-name: expected";

        ok verify( $str, @permutation ),   "$test-name: verified" if DEBUG;
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
Example 1 |IDID               |0 4 1 3  2
Example 2 |III                |0 1 2 3
Example 3 |DDI                |3 2 0 1
Long str 1|IIIDDIDIDIDIIIIDIII|0 1 2 19 18 3 17 4 16 5 15 6 7 8 9 14 10 11 12 13
All Ds    |DDDDDDD            |7 6 5 4 3 2 1 0
Single D  |D                  |1 0
Long str 2|DIDIIDDIIIIIIDDDDII|19 0 18 1 2 17 16 3 4 5 6 7 8 15 14 13 12 9 10 11
Alternates|IDIDIDIDIDIDIDIDIDI|0 19 1 18 2 17 3 16 4 15 5 14 6 13 7 12 8 11 9 10
END
}

################################################################################

use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 190
=========================

TASK #2
-------
*Decoded List*

Submitted by: Mohammad S Anwar

You are given an encoded string consisting of a sequence of numeric characters:
0..9, $s.

Write a script to find the all valid different decodings in sorted order.

    Encoding is simply done by mapping A,B,C,D,… to 1,2,3,4,… etc.

Example 1

  Input: $s = 11
  Output: AA, K

  11 can be decoded as (1 1) or (11) i.e. AA or K

Example 2

  Input: $s = 1115
  Output: AAAE, AAO, AKE, KAE, KO

  Possible decoded data are:
  (1 1 1 5) => (AAAE)
  (1 1 15)  => (AAO)
  (1 11 5)  => (AKE)
  (11 1 5)  => (KAE)
  (11 15)   => (KO)

Example 3

  Input: $s = 127
  Output: ABG, LG

  Possible decoded data are:
  (1 2 7) => (ABG)
  (12 7)  => (LG)

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

Discussion
----------
The task description specifies that the input string must be "a sequence of
numeric characters: 0..9," so 0 is explicitly allowed in the input. But encod-
ing to capital letters begins at 1, with 1 -> A, 2 -> B, etc. So how should the
zero digit (0) be treated?

If 0 is excluded, this would not only contradict the task specification but
would also prevent the letters 'J' and 'T' from ever appearing in the decoded
output.

After some consideration, I have decided to follow the specification and allow
0 in the input string, and to decode a single 0 as the empty string. Hence,
10234 decodes as follows:

    (1 0 2 3 4) => (A''BCD) => (ABCD)
    (1 02  3 4) => (ABCD)
    (1 0  23 4) => (A''WD)  => (AWD)
    (10 2  3 4) => (JBCD)
    (10 23   4) => (JWD)

which, sorted, and with duplicates removed, produces:

    10234 => ABCD, AWD, JBCD, JWD

Algorithm
---------
Decoding of numbers to letters is deferred until all valid digit partitions
have been found. The algorithm begins by creating array @num-sets, which will
hold all valid digit partitions, and initialising it to a single partition in
which all the numbers are single digits (0 to 9).

Then, for each index $i in the range 0 to the index of the penultimate digit in
$s, each partition in @num_sets is examined to determine whether the numbers at
index $i and index $i + 1 can be combined into a 2-digit number within the
allowable range (viz., 10 to 26). Only single-digit numbers between 1 and 9 are
considered as candidates for combining at this step. If the resulting 2-digit
number is valid, a new partition is created with this 2-digit number replacing
the digits previously at indices $i and $i + 1, and this new partition is added
to @num-sets.

When all values of $i have been processed, @num-sets holds all the valid number
partitions for $s. Each partition is then decoded to its corresponding letters.
Duplicates are removed, and the decoded letter-strings are returned in ascend-
ing alphabetical order.

=end comment
#==============================================================================

use Test;

my UInt constant $MAX-DIGIT   =  9;
my UInt constant $MAX-INDEX   = 26;
my UInt constant $TEST-FIELDS =  3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 190, Task #2: Decoded List (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    Str:D $s where { $s ~~ / ^ <[0..9]>+ $ / }      #= A string of digits (0-9)
)
#==============================================================================
{
    "Input:  \$s = $s".put;

    my Str @decodings = decode( $s );

    "Output: %s\n".printf: @decodings.join: ', ';
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub decode( Str:D $s --> Seq:D[Str:D] )
#------------------------------------------------------------------------------
{
    my Array[UInt] @num-sets;

    @num-sets.push: Array[UInt].new: $s.split( '', :skip-empty ).map: { .Int };

    for 0 .. $s.chars - 2 -> UInt $i
    {
        for @num-sets -> Array[UInt] $set
        {
            if $i < $set.end
            {
                my UInt $first  =  $set[ $i     ];
                my UInt $second =  $set[ $i + 1 ];
                my UInt $pair   = ($first ~ $second).Int;

                if 0 < $first  <= $MAX-DIGIT &&
                       $second <= $MAX-DIGIT &&
                       $pair   <= $MAX-INDEX
                {
                    my UInt @new-set = @$set;

                    @new-set.splice: $i, 2, $pair;

                    @num-sets.push: @new-set;
                }
            }
        }
    }

    return decode-number-sets( @num-sets );;
}

#------------------------------------------------------------------------------
sub decode-number-sets( List:D[Array:D[UInt:D]] $num-sets --> Seq:D[Str:D] )
#------------------------------------------------------------------------------
{
    my UInt $offset = 'A'.ord - 1;
    my Str  @words;

    for @$num-sets -> Array[UInt] $set
    {
        my Str $word = '';

        for @$set -> UInt $num
        {
            if 0 <= $num <= $MAX-INDEX
            {
                $word ~= chr( $offset + $num ) unless $num == 0;
            }
            else
            {
                qq[Index "$num" out of range].note;
            }
        }

        @words.push: $word;
    }

    return @words.unique.sort;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $s, $expected) =
            $line.split: / \, \s* /, $TEST-FIELDS, :skip-empty;

        $expected //= '';
        $expected ~~ s:g/ (<[A .. Z]>) \s+ /$0, /;

        my Str $output = decode( $s ).sort.join: ', ';

        is $output, $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1,    11,    AA   K
        Example 2,    1115,  AAAE AAO AKE  KAE KO
        Example 3,    127,   ABG  LG
        One zero (1), 1012,  AAB  AL  JAB  JL
        All zeros,    000,
        One zero (2), 10234, ABCD AWD JBCD JWD
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

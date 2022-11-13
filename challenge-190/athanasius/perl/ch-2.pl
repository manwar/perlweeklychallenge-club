#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

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
have been found. The algorithm begins by creating array @num_sets, which will
hold all valid digit partitions, and initialising it to a single partition in
which all the numbers are single digits (0 to 9).

Then, for each index $i in the range 0 to the index of the penultimate digit in
$s, each partition in @num_sets is examined to determine whether the numbers at
index $i and index $i + 1 can be combined into a 2-digit number within the
allowable range (viz., 10 to 26). Only single-digit numbers between 1 and 9 are
considered as candidates for combining at this step. If the resulting 2-digit
number is valid, a new partition is created with this 2-digit number replacing
the digits previously at indices $i and $i + 1, and this new partition is added
to @num_sets.

When all values of $i have been processed, @num-sets holds all the valid number
partitions for $s. Each partition is then decoded to its corresponding letters.
Duplicates are removed, and the decoded letter-strings are returned in ascend-
ing alphabetical order.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use List::MoreUtils qw( uniq );
use Test::More;

const my $MAX_DIGIT   =>  9;
const my $MAX_INDEX   => 26;
const my $TEST_FIELDS =>  3;
const my $USAGE       =>
"Usage:
  perl $0 <s>
  perl $0

    <s>    A string of digits (0-9)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 190, Task #2: Decoded List (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 1)
    {
        my $s = $ARGV[ 0 ];

        $s =~ / ([^0-9]) /x
            and error( qq["$1" is not a valid digit] );

        print  "Input:  \$s = $s\n";

        my @decodings = decode( $s );

        printf "Output: %s\n", join ', ', @decodings;
    }
    else
    {
        error( "Expected 0 or 1 arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub decode
#------------------------------------------------------------------------------
{
    my ($s) = @_;

    my @num_sets = [ split //, $s ];

    for my $i (0 .. length( $s ) - 2)
    {
        for my $set (@num_sets)
        {
            if ($i < $#$set)
            {
                my $first  = $set->[ $i     ];
                my $second = $set->[ $i + 1 ];
                my $pair   = $first . $second;

                if (0 < $first  <= $MAX_DIGIT &&
                        $second <= $MAX_DIGIT &&
                        $pair   <= $MAX_INDEX)
                {
                    my     @new_set = @$set;
                    splice @new_set, $i, 2, $pair;
                    push   @num_sets, \@new_set;
                }
            }
        }
    }

    return decode_number_sets( \@num_sets );
}

#------------------------------------------------------------------------------
sub decode_number_sets
#------------------------------------------------------------------------------
{
    my ($num_sets) = @_;
    my  $offset    = ord( 'A' ) - 1;
    my  @words;

    for my $set (@$num_sets)
    {
        my $word = '';

        for my $num (@$set)
        {
            if (0 <= $num <= $MAX_INDEX)
            {
                $word .= chr( $offset + $num ) unless $num == 0;
            }
            else
            {
                warn qq[Index "$num" out of range];
            }
        }

        push @words, $word;
    }

    return uniq sort @words;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $s, $expected) =
            split / , \s* /x, $line, $TEST_FIELDS;

        $expected  =~ s/ ([A-Z]) \s+ /$1, /gx;

        my $output = join ', ', sort +decode( $s );

        is $output, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1,    11,    AA   K
Example 2,    1115,  AAAE AAO AKE  KAE KO
Example 3,    127,   ABG  LG
One zero (1), 1012,  AAB  AL  JAB  JL
All zeros,    000,
One zero (2), 10234, ABCD AWD JBCD JWD

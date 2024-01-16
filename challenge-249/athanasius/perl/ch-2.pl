#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. Command-line arguments:
     i. None: the test suite is run.
    ii. A non-empty string s consisting of only the characters "D" and/or "I":
        a solution is found for s.
   iii. A single integer n > 0: an input string s of n characters is randomly
        generated, then a solution is found for s.

2. If $DEBUG is set to a true value, each solution is checked to verify that it
   satisfies the given criteria.

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

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $DEBUG => 1;
const my $USAGE => <<END;
Usage:
  perl $0 <len>
  perl $0 <str>
  perl $0

    <len>    Integer > 0: length of string to be generated
    <str>    Non-empty string consisting of only the characters "D" and "I"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 249, Task #2: DI String Match (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        my $str = parse_command_line();

        print qq[Input:  \$str = "$str"\n];

        my $permutation = DI_string_match( $str );

        if ($DEBUG && !verify( $str, $permutation ))
        {
            die sprintf qq[Permutation (%s) for "%s" failed verification],
                        join( ', ', @$permutation ), $str;
        }

        printf "Output: (%s)\n", join ', ', @$permutation;
    }
    else
    {
        error( "Expected 1 or 0 parameters, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub DI_string_match
#-------------------------------------------------------------------------------
{
    my ($str) =  @_;
        $str  =~ / ^ [DI]+ $ /x
                 or die qq[DI_string_match(): invalid \$str argument "$str"];
    my  @perm;
    my  $len  =  length $str;
    my  @ints =  0  ..  $len;

    for my $i (0 .. $len - 1)
    {
        if (substr( $str, $i, 1 ) eq 'D')
        {
            $perm[ $i ] = pop   @ints;
        }
        else
        {
            $perm[ $i ] = shift @ints;
        }
    }

    $perm[ $len ] = shift @ints;

    return \@perm;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my  $str = $ARGV[ 0 ];

    if ($str =~ / ^ $RE{num}{int} $ /x && $str > 0)
    {
        $str = generate_string( $str );
    }
    else
    {
        $str =~ / ^ [DI]+ $ /x
            or error( qq[Invalid string argument "$str"] );
    }

    return $str;
}

#-------------------------------------------------------------------------------
sub generate_string
#-------------------------------------------------------------------------------
{
    my ($len) = @_;
    my  $str  = '';

    for (1 .. $len)
    {
        my $char = int rand( 2 ) ? 'D' : 'I';

        $str .= $char;
    }

    return $str;
}

#-------------------------------------------------------------------------------
sub verify
#-------------------------------------------------------------------------------
{
    my ($str, $perm) = @_;

    for my $i (0 .. length( $str ) - 1)
    {
        my $first  = $perm->[ $i     ];
        my $second = $perm->[ $i + 1 ];

        if (substr( $str, $i, 1 ) eq 'D')
        {
            return 0 unless $first > $second;
        }
        else    # 'I'
        {
            return 0 unless $first < $second;
        }
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected_str) = split / \| /x, $line;

        for ($test_name, $str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $permutation = DI_string_match( $str );
        my @expected    = split / \s+ /x, $expected_str;

        is_deeply $permutation, \@expected, "$test_name: expected";

        ok verify( $str, $permutation ),    "$test_name: verified" if $DEBUG;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1 |IDID               |0 4 1 3  2
Example 2 |III                |0 1 2 3
Example 3 |DDI                |3 2 0 1
Long str 1|IIIDDIDIDIDIIIIDIII|0 1 2 19 18 3 17 4 16 5 15 6 7 8 9 14 10 11 12 13
All Ds    |DDDDDDD            |7 6 5 4 3 2 1 0
Single D  |D                  |1 0
Long str 2|DIDIIDDIIIIIIDDDDII|19 0 18 1 2 17 16 3 4 5 6 7 8 15 14 13 12 9 10 11
Alternates|IDIDIDIDIDIDIDIDIDI|0 19 1 18 2 17 3 16 4 15 5 14 6 13 7 12 8 11 9 10

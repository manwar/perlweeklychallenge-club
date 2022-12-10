#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. To display the character (if any) whose removal can equalize the frequencies
   of the remaining characters, set $VERBOSE to a true value. (This has no
   effect on the running of the test suite.)

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

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $TST_FLDS => 3;
const my $VERBOSE  => 1;
const my $USAGE    =>
qq[Usage:
  perl $0 <s>
  perl $0

    <s>    A string composed of lower case letters "a" to "z" only\n];

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 194, Task #2: Frequency Equalizer (Perl)\n\n";
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
        my $s =  $ARGV[ 0 ];
           $s =~ /([^a-z])/ and error( qq[Invalid character "$1"] );

        print   qq[Input:  \$s = "$s"\n];

        my $char = char2remove( $s );

        printf "Output: %d", $char ? 1 : 0;
        print   qq[ (remove one letter "$char")] if $VERBOSE && $char;
        print  "\n";
    }
    else
    {
        error( "Expected 1 or 0 arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub char2remove
#------------------------------------------------------------------------------
{
    my ($s)  = @_;
    my  $len = length $s;

    return ''                 if $len == 0;
    return $s                 if $len == 1;
    return substr( $s, 0, 1 ) if $len == 2;

    my (%char2freq, %freq2char);
      ++$char2freq{ $_ } for split //, $s;                  # Count frequencies

    while (my ($key, $value) = each %char2freq)             # Reverse the hash
    {
        push @{ $freq2char{ $value } }, $key;
    }

    my @keys   = keys %freq2char;
    my $n_keys = scalar @keys;

    return @{ $freq2char{ $keys[ 0 ] } }[ 0 ]
        if $n_keys == 1 && scalar @{ $freq2char{ $keys[ 0 ] } } == 1;

    return '' unless $n_keys == 2;

    my ($low, $high) = sort { $a <=> $b } @keys;

    return '' unless scalar @{ $freq2char{ $high } } == 1;

    return ($high == $low + 1) ? @{ $freq2char{ $high } }[ 0 ] : '';
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

        my ($test_name, $s, $expected) = split / , \s* /x, $line, $TST_FLDS;
        my  $got = char2remove( $s ) ? 1 : 0;

        is  $got, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1,      abbc,    1
Example 2,      xyzyyxz, 1
Example 3,      xzxz,    0
Empty string,   ,        0
Single letter,  j,       1
Same letters 2, dd,      1
Same letters 5, eeeee,   1
Distinct pair,  ab,      1

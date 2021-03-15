#!perl

###############################################################################
=comment

Perl Weekly Challenge 099
=========================

Task #1
-------
*Pattern Match*

Submitted by: Mohammad S Anwar

You are given a string $S and a pattern $P.

Write a script to check if given pattern validate the entire string. Print 1 if
pass otherwise 0.

The patterns can also have the following characters:

? - Match any single character.
* - Match any sequence of characters.

Example 1:

 Input: $S = "abcde" $P = "a*e"
 Output: 1

Example 2:

 Input: $S = "abcde" $P = "a*d"
 Output: 0

Example 3:

 Input: $S = "abcde" $P = "?b*d"
 Output: 0

Example 4:

 Input: $S = "abcde" $P = "a*c?e"
 Output: 1

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------

The special pattern character "*" is specified to "Match any sequence of char-
acters". Does this include a zero-length sequence? In the absence of further
information the answer is assumed to be Yes.

The Task description does not specify whether the empty string is a legal
pattern. For the sake of convenience, the empty string is here disallowed as a
pattern (but it is allowed for $S, in which case the output will always be 0).

Solution
--------

Advantage is taken of Perl's built-in regular expression functionality: $P is
transformed into a regex pattern by substituting "." for "?" and ".*" for "*",
respectively.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $USAGE =>
"Usage:
  perl $0 <S> <P>

    <S>    A string
    <P>    A pattern (non-empty string)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 099, Task #1: Pattern Match (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($S, $P) = parse_command_line();

    print qq[Input:  \$S = "$S" \$P = "$P"\n];

    $P =~ s/ \? /./gx;
    $P =~ s/ \* /.*/gx;

    printf "Output: %d\n", $S =~ / ^ $P $ /x ? 1 : 0;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 2 or error( "Expected 2 command-line arguments, found $args" );

    my ($S, $P) = @ARGV;

    length $P > 0 or error( 'The pattern string must not be empty' );

    return ($S, $P);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

#!perl

###############################################################################
=comment

Perl Weekly Challenge 102
=========================

Task #2
-------
*Hash-counting String*

Submitted by: Stuart Little

You are given a positive integer $N.

Write a script to produce Hash-counting string of that length.

The definition of a hash-counting string is as follows:

- the string consists only of digits 0-9 and hashes, '#'
- there are no two consecutive hashes: '##' does not appear in your string
- the last character is a hash
- the number immediately preceding each hash (if it exists) is the position of
  that hash in the string, with the position being counted up from 1

It can be shown that for every positive integer N there is exactly one such
length-N string.

Examples:

 (a) "#" is the counting string of length 1
 (b) "2#" is the counting string of length 2
 (c) "#3#" is the string of length 3
 (d) "#3#5#7#10#" is the string of length 10
 (e) "2#4#6#8#11#14#" is the string of length 14

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm: a straightforward recursive solution.

Since a string ends in '#', we can begin at the end and construct the string
backwards. For example, for $N = 5, the string must end '5#'; and since this
suffix occupies 2 characters, the remaining string must have 3 characters.
Repeat the search for $N = 3: this part must be '3#', leaving 1 character,
which, by the definition, must be '#'. Hence, the final string is:

    '#' . '3#' . '5#' = '#3#5#'.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 <N>

    <N>    Positive integer: length of the required hash-counting string\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 102, Task #2: Hash-counting String (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N = parse_command_line();

    print "Input:  $N\n";

    printf qq[Output: "%s"\n], make_hash_counting_string( $N );
}

#------------------------------------------------------------------------------
sub make_hash_counting_string                            # Recursive subroutine
#------------------------------------------------------------------------------
{
    no warnings qw( recursion );

    my ($N) = @_;

    return ''  if $N == 0;
    return '#' if $N == 1;

    my $tail    = $N . '#';
    my $new_len = $N - length $tail;
    my $head    = make_hash_counting_string( $new_len );

    return $head . $tail;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args =  scalar @ARGV;
       $args == 1 or error( "Expected 1 command-line argument, found $args" );

    my $N =  $ARGV[0];
       $N =~ / ^ $RE{num}{int} $ /x && $N > 0
                  or error( qq["$N" is not a positive integer] );

    return $N;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

#!perl

###############################################################################
=comment

Perl Weekly Challenge 180
=========================

TASK #2
-------
*Trim List*

Submitted by: Mohammad S Anwar

You are given list of numbers, @n and an integer $i.

Write a script to trim the given list where element is less than or equal to
the given integer.

Example 1

  Input: @n = (1,4,2,3,5) and $i = 3
  Output: (4,5)

Example 2

  Input: @n = (9,0,6,2,3,8,5) and $i = 4
  Output: (9,6,8,5)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption
----------
$i must be an integer (as specified), but the elements of @n may be any real
numbers.

Interface
---------
$i is given first on the command line, followed by the elements of @n.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $SEP   => ', ';
const my $USAGE =>
qq[Usage:
  perl $0 <i> [<n> ...]

    <i>          An integer
   [<n> ...]     One or more real numbers\n];

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 180, Task #2: Trim List (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($i, @n) = parse_command_line();

    printf "Input:  \@n = (%s) and \$i = %d\n", join( $SEP, @n ), $i;

    printf "Output: (%s)\n", join $SEP, grep { $_ > $i } @n;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args  = scalar @ARGV;
       $args >= 2 or error( "Expected at least 2 arguments, found $args" );

    my ($i, @n) = @ARGV;

        $i =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$i" is not a valid integer] );

    for my $n (@n)
    {
        $n =~ / ^ $RE{num}{real} $ /x
                  or error( qq["$n" is not a valid real number] );
    }

    return ($i, @n);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

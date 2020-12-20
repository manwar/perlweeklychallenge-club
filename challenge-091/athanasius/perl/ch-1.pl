#!perl

###############################################################################
=comment

Perl Weekly Challenge 091
=========================

Task #1
-------
*Count Number*

Submitted by: Mohammad S Anwar

You are given a positive number $N.

Write a script to count number and display as you read it.

Example 1:

 Input: $N = 1122234
 Output: 21321314

 as we read "two 1 three 2 one 3 one 4"

Example 2:

 Input: $N = 2333445
 Output: 12332415

 as we read "one 2 three 3 two 4 one 5"

Example 3:

 Input: $N = 12345
 Output: 1112131415

 as we read "one 1 one 2 one 3 one 4 one 5"

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 <N>

    <N>    A positive integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 091, Task #1: Count Number (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N = parse_command_line();

    print "Input:  \$N = $N\n";
    print 'Output: ';

    my @digits     = split //, $N;
    my $last_digit = shift @digits;
    my $count      = 1;

    # Note: the test for definedness is needed for when $next_digit is zero

    while (defined(my $next_digit = shift @digits))
    {
        if ($next_digit == $last_digit)
        {
            ++$count;
        }
        else
        {
            print "$count$last_digit";

            $last_digit = $next_digit;
            $count      = 1;
        }
    }

    print "$count$last_digit\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args =  scalar @ARGV;
       $args == 0 and error( 'No command-line arguments found' );
       $args == 1 or  error( 'Too many command-line arguments' );

    my $N =  $ARGV[0];
       $N =~ / \A $RE{num}{int} \z /x or error( qq["$N" is not an integer] );
       $N >  0                        or error( qq["$N" is not positive]   );

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

#!perl

###############################################################################
=comment

Perl Weekly Challenge 135
=========================

TASK #2
-------
*Validate SEDOL*

Submitted by: Mohammad S Anwar

You are given 7-characters alphanumeric SEDOL.

Write a script to validate the given SEDOL. Print 1 if it is a valid SEDOL
otherwise 0.

For more information about SEDOL, please checkout the
[ https://en.wikipedia.org/wiki/SEDOL |wikipedia] page.

Example 1

  Input: $SEDOL = '2936921'
  Output: 1

Example 2

  Input: $SEDOL = '1234567'
  Output: 0

Example 3

  Input: $SEDOL = 'B0YBKL9'
  Output: 1

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
no  Carp::Assert;
use Const::Fast;
use Getopt::Long;

const my $USAGE =>
"Usage:
  perl $0 [--verbose|-v] <SEDOL>

    <SEDOL>        7-character alphanumeric SEDOL string
    --v[erbose]    Print annotated output?\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 135, Task #2: Validate SEDOL (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($SEDOL, $verbose) = parse_command_line();

    print "Input:  \$SEDOL = '$SEDOL'\n";

    my $valid   =  0;
    my $message = '';

    if ((my $length = length $SEDOL) == 7)
    {
        my $code = substr $SEDOL, 0, 6;

        ($valid, $message) = validate_code( $code );

        if ($valid)
        {
            my $check = substr $SEDOL, 6, 1;

            ($valid, $message) = validate_check_digit( $code, $check );
        }
    }
    else
    {
        $message = "Invalid number of characters: found $length, must be 7", 
    }

    printf "Output: %d%s\n", $valid ? 1 : 0, $verbose ? " ($message)" : '';
}

#------------------------------------------------------------------------------
sub validate_code
#------------------------------------------------------------------------------
{
    my ($code) = @_;

    assert( length $code == 6 ) if DEBUG;

    my $valid   = 1;
    my $message = '';

    for my $i (0 .. 5)
    {
        my $char = substr $code, $i, 1;

        if ($char !~ /[0-9B-DF-HJ-NP-TV-Z]/)
        {
            $valid   = 0;
            $message = "Invalid code character '$char'";
            last;
        }
    }

    return ($valid, $message);
}

#------------------------------------------------------------------------------
sub validate_check_digit
#------------------------------------------------------------------------------
{
    my ($code, $check) = @_;

    assert( length $code  == 6 ) if DEBUG;
    assert( length $check == 1 ) if DEBUG;

    my $valid   =  0;
    my $message = '';

    if ($check =~ /[0-9]/)
    {
        my $check_digit = get_check_digit( $code );

        if ($check == $check_digit)
        {
            $valid   = 1;
            $message = 'The check digit is correct';
        }
        else
        {
            $message = "Incorrect check digit: found '$check', should be " .
                       "'$check_digit'";
        }
    }
    else
    {
        $message = "Invalid check digit '$check'";
    }

    return ($valid, $message);
}

#------------------------------------------------------------------------------
sub get_check_digit
#------------------------------------------------------------------------------
{
    my ($code) = @_;

    assert( length $code == 6 ) if DEBUG;

    my @weighting    = (1, 3, 1, 7, 3, 9, 1);
    my $weighted_sum =  0;

    for my $i (0 .. 5)
    {
        my $char  = substr $code, $i, 1;
        my $value = $char =~ /[0-9]/ ? $char : 10 + ord( $char ) - ord( 'A' );

        $weighted_sum += $value * $weighting[ $i ];
    }

    return (10 - ($weighted_sum % 10)) % 10;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $verbose = 0;

    GetOptions( verbose => \$verbose )
                  or error( 'Invalid command line flag' );

    my $args = scalar @ARGV;
       $args == 1 or error( 'Invalid number of command line arguments' );

    return ($ARGV[ 0 ], $verbose);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

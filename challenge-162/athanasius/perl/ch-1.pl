#!perl

###############################################################################
=comment

Perl Weekly Challenge 162
=========================

TASK #1
-------
*ISBN-13*

Submitted by: Mohammad S Anwar

Write a script to generate the check digit of given ISBN-13 code. Please refer
[ https://en.wikipedia.org/wiki/International_Standard_Book_Number#ISBN-13_
check_digit_calculation |wikipedia] for more information.

Example

  ISBN-13 check digit for '978-0-306-40615-7' is 7.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Note
----
The following are accepted as input:

 - A 13-digit ISBN code
 - A 12-digit ISBN code, optionally followed by a question mark to indicate the
   unknown check digit
 - A 10-digit ISBN code, which will be converted to its 13-digit equivalent.
   This must include a check digit, but it will not be checked for correctness.

All forms may contain separators (spaces or hyphens). No checks are made for
the correctness of separator placement.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Devel::Assert qw( on );

const my $USAGE =>
"Usage:
  perl $0 <code>

    <code>    10-, 12-, or 13-digit ISBN code (may contain separators)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 162, Task #1: ISBN-13 (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $code = validate_code();

    printf "Input:  %s\n", $ARGV[ 0 ];

    my @digits = split '', $code =~ s/ [^\d] //rgx;

    assert scalar @digits == 12;

    for (my $i = 1; $i < scalar @digits; $i += 2)
    {
        $digits[ $i ] *= 3;
    }

    my $sum   =  0;
       $sum  +=  $_ for @digits;
    my $r     =  10 - ($sum % 10);
    my $check =  $r < 10 ? $r : 0;
       $code  =~ s/ \? $ //x;                             # Remove trailing '?'
       $code .=  '-' unless $code =~ / \- $ /x;           # Add trailing hyphen

    printf "Output: ISBN-13 check digit for '%s' is %d\n",
            $code . $check, $check;
}

#------------------------------------------------------------------------------
sub validate_code
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1
            or  error( "Expected 1 command line argument, found $args" );

    my $code =  $ARGV[ 0 ];
       $code =~ s/ [ -] //gx;                  # Remove separators     (if any)
       $code =~ s/ \? $ //x;                   # Remove a trailing '?' (if any)
       $code =~ / ([^0-9]) /x                  # Look for illegal characters
            and error( qq(Invalid input character "$1") );

    my $len  =  length $code;
       $code =  $ARGV[ 0 ];                    # Restore original separators

    if    ($len == 10)
    {
        $code = '978-' . $code;
        chop $code;                            # Remove trailing check digit
    }
    elsif ($len == 13)
    {
        chop $code;                            # Remove trailing check digit
    }
    elsif ($len != 12)                         # Missing check digit is allowed
    {                                          # for ISBN-13 (not for ISBN-10)
        error( 'Invalid length' );
    }

    return $code;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

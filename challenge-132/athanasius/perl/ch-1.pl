#!perl

###############################################################################
=comment

Perl Weekly Challenge 132
=========================

TASK #1
-------
*Mirror Dates*

Submitted by: Mark Anderson

You are given a date (yyyy/mm/dd).

Assuming, the given date is your date of birth. Write a script to find the
mirror dates of the given date.

Dave Cross has built cool [https://davorg.dev/mirroryear|site] that does some-
thing similar.

Assuming today is 2021/09/22.

Example 1:

 Input: 2021/09/18
 Output: 2021/09/14, 2021/09/26

 On the date you were born, someone who was your current age, would have been
 born on 2021/09/14.
 Someone born today will be your current age on 2021/09/26.

Example 2:

 Input: 1975/10/10
 Output: 1929/10/27, 2067/09/05

 On the date you were born, someone who was your current age, would have been
 born on 1929/10/27.
 Someone born today will be your current age on 2067/09/05.

Example 3:

 Input: 1967/02/14
 Output: 1912/07/08, 2076/04/30

 On the date you were born, someone who was your current age, would have been
 born on 1912/07/08.
 Someone born today will be your current age on 2076/04/30.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Notes
-----
Today's date may be overridden for testing by setting $TEST to a true value.
A sanity check is also provided to ensure that the input date is earlier than
today's date. Dates must be entered in "yyyy/mm/dd" format with slash (/)
separators, but initial zeros may be omitted: e.g., "2021/9/2" is accepted.

For the date calculations, all the heavy lifting is delegated to the DateTime
module from CPAN.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use DateTime;

const my $TEST  => 0;       # Optionally override the current day (for testing)
const my %DATE  => ( year => 2021, month => 9, day => 22 );
const my $USAGE =>
qq[Usage:
  perl $0 <date_str>

    <date_str>  A string of the form "yyyy/mm/dd" representing a valid date\n];

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 132, Task #1: Mirror Dates (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $date  = parse_command_line();
    my $today = $TEST ? DateTime->new( %DATE ) : DateTime->now;

    printf "Input:  %s\n", $date ->ymd( '/' );
    printf "Today:  %s\n", $today->ymd( '/' );

    unless ($today->subtract_datetime( $date )->is_positive)
    {
        print "\n";
        error( "The input date must be earlier than today's date" );
    }

    my $delta   = $today->delta_days( $date  );
    my $mirror1 = $date ->subtract  ( $delta );
    my $mirror2 = $today->add       ( $delta );

    printf "Output: %s, %s\n", $mirror1->ymd( '/' ),
                               $mirror2->ymd( '/' );
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1
            or error( "Expected 1 command line argument, found $args" );

    my $date_str = $ARGV[ 0 ];
       $date_str =~ m[ ^ (\d{1,4}) / (\d{1,2}) / (\d{1,2}) $ ]x
            or error( 'Unsupported date format' );

    my $date;

    eval
    {
        $date = DateTime->new( year => $1, month => $2, day => $3 );
    };

    $@     and error( qq["$date_str" is not a valid date] );

    return $date;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Notes
-----
Today's date may be overridden for testing by setting the constant TEST to
True. A sanity check is also provided to ensure that the input date is earlier
than today's date. Dates must be entered in "yyyy/mm/dd" format with slash (/)
separators, but initial zeros may be omitted: e.g., "2021/9/2" is accepted.

For the date calculations, all of the required functionality is present in
Raku's inbuilt Date class, which overloads the '+' and '-' operators in a DWIM
fashion. Specifically:
    Date  -  Date  produces a difference in days, and
    Date +/- days  produces a new Date object.

=end comment
#==============================================================================

# Optionally override the current day (for testing against the Examples)

my Bool constant TEST  = False;
my Str  constant TODAY = '2021-09-22';

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 132, Task #1: Mirror Dates (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| A string of the form "yyyy/mm/dd" representing a valid date

    Str:D $date-str
)
#==============================================================================
{
    my Date $date  = parse-command-line( $date-str );
    my Date $today = TEST ?? Date.new( TODAY ) !! Date.today;

    "Input:  %s\n".printf: $date\.yyyy-mm-dd: '/';
    "Today:  %s\n".printf: $today.yyyy-mm-dd: '/';

    my Int  $delta = $today - $date;

    if $delta <= 0
    {
        ''.put;
        error( "The input date must be earlier than today's date" );
    }

    my Date $mirror1 = $date  - $delta;
    my Date $mirror2 = $today + $delta;

    "Output: %s, %s\n".printf: $mirror1.yyyy-mm-dd( '/' ),
                               $mirror2.yyyy-mm-dd( '/' );
}

#------------------------------------------------------------------------------
sub parse-command-line( Str:D $date-str --> Date:D )
#------------------------------------------------------------------------------
{
    $date-str ~~ rx{ ^ $<year>  = [ \d ** 1..4 ] '/'
                       $<month> = [ \d ** 1..2 ] '/'
                       $<day>   = [ \d ** 1..2 ] $ }
         or error( 'Unsupported date format' );

    my Date $date = Date.new( $<year>, $<month>, $<day> );

    CATCH
    {
        when X::OutOfRange
        {
            error( qq["$date-str" is not a valid date] );
        }
    }

    return $date;
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################

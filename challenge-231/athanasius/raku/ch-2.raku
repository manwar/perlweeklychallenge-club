use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 231
=========================

TASK #2
-------
*Senior Citizens*

Submitted by: Mohammad S Anwar

You are given a list of passenger details in the form “9999999999A1122”, where 9
denotes the phone number, A the sex, 1 the age and 2 the seat number.

Write a script to return the count of all senior citizens (age >= 60).

Example 1

  Input: @list = ("7868190130M7522","5303914400F9211","9273338290F4010")
  Output: 2

  The age of the passengers in the given list are 75, 92 and 40.
  So we have only 2 senior citizens.

Example 2

  Input: @list = ("1313579440F2036","2921522980M5644")
  Output: 0

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
An invalid passenger-detail string should generate a warning, but otherwise be
ignored.

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

subset Passenger of List where (Bool, UInt, Str, UInt, UInt);

enum < VALID PHONE SEX AGE SEAT >;

my UInt constant $SENIOR-AGE =  60;
my UInt constant $STRING-LEN = '9999999999A1122'.chars;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 231, Task #2: Senior Citizens (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@list where { .elems > 0 }  #= A non-empty list of passenger-detail strings
)
#===============================================================================
{
    "Input:  \@list = (%s)\n".printf: @list.map( { qq["$_"] } ).join: ',';

    "Output: %d\n".printf: count-seniors( @list );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-seniors( List:D[Str:D] $list --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $count = 0;

    for @$list -> Str $string
    {
        my Passenger $details = parse-passenger-details( $string );

        if $details[ VALID ]
        {
            ++$count if $details[ AGE ] >= $SENIOR-AGE;
        }
        else
        {
            qq[WARNING: Ignoring invalid passenger information "$string"].put;
        }
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub parse-passenger-details( Str:D $string --> Passenger:D )
#-------------------------------------------------------------------------------
{
    #                                  VALID? PHONE SEX  AGE   SEAT
    my Passenger $details = Array.new( False, UInt, Str, UInt, UInt );

    if $string.chars == $STRING-LEN
    {
        my Str $phone = $string.substr: 0, 10;

        if $phone ~~ / ^ \d ** 10 $ /
        {
            $details[ PHONE ] = $phone.Int;
            my Str $sex       = $string.substr: 10, 1;

            if $sex ~~ / ^ <[MF]> $ /
            {
                $details[ SEX ] = $sex;
                my Str $age     = $string.substr: 11, 2;

                if $age ~~ / ^ \d ** 2 $ /
                {
                    $details[ AGE ] = $age.Int;
                    my Str $seat    = $string.substr: 13, 2;

                    if $seat ~~ / ^ \d ** 2 $ /
                    {
                        $details[ VALID, SEAT ] = True, $seat.Int;
                    }
                }
            }
        }
    }

    return $details;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $passenger-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $passenger-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @list  = $passenger-str.split: / \s+ /, :skip-empty;
        my UInt $count = count-seniors( @list );

        is $count, $exp-str.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1   |7868190130M7522 5303914400F9211 9273338290F4010|2
        Example 2   |1313579440F2036 2921522980M5644                |0
        Similar ages|5551234567M5901 5557654321F6002 5551928374M6103|2
        END
}

################################################################################

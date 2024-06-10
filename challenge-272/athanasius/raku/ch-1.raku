use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 272
=========================

TASK #1
-------
*Defang IP Address*

Submitted by: Mohammad Sajid Anwar

You are given a valid IPv4 address.

Write a script to return the defanged version of the given IP address.

    A defanged IP address replaces every period “.” with “[.]".

Example 1

  Input: $ip = "1.1.1.1"
  Output: "1[.]1[.]1[.]1"

Example 2

  Input: $ip = "255.101.1.0"
  Output: "255[.]101[.]1[.]0"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The given IP address is in quad-dotted notation: 4 decimal numbers (octets),
   each in the range 0 to 255, separated by dots (periods).
2. For octets, leading zeros are allowed, but leading "+" signs are not.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The IP to be defanged is entered on the command-line as a single string.

=end comment
#===============================================================================

use Test;

my UInt constant OCTET-MAX = 255;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 272, Task #1: Defang IP Address (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $ip           #= A valid IP address in quad-dotted notation
)
#===============================================================================
{
    is-valid-ip( $ip ) or error( qq[Invalid IP "$ip"] );

    qq[Input:  \$ip = "$ip"].put;

    my Str $defanged = defang( $ip );

    qq[Output: "$defanged"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub defang( Str:D $ip --> Str:D )
#-------------------------------------------------------------------------------
{
    return S:g{ \. } = '[.]' with $ip;
}

#-------------------------------------------------------------------------------
sub is-valid-ip( Str:D $ip --> Bool:D ) 
#-------------------------------------------------------------------------------
{
    return False unless $ip ~~ / ^ <[ 0..9 . ]>+ $ /;

    my Str @octets = $ip.split: '.', :skip-empty;

    return False unless @octets.elems == 4;

    for @octets
    {
        return False unless +$_ ~~ UInt:D && +$_ <= OCTET-MAX;
    }

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ip, $expected) = $line.split: / \| /;

        for     $test-name, $ip, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        is-valid-ip( $ip ) or error( qq[Invalid IP "$ip"] );

        my Str $defanged = defang( $ip );

        is $defanged, $expected, $test-name;
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
        Example 1|1.1.1.1    |1[.]1[.]1[.]1
        Example 2|255.101.1.0|255[.]101[.]1[.]0
        END
}

################################################################################

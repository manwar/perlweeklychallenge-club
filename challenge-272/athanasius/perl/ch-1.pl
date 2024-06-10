#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. The given IP address is in quad-dotted notation: 4 decimal numbers (octets),
   each in the range 0 to 255, separated by dots (periods).
2. For octets, leading zeros are allowed, but leading "+" signs are not.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The IP to be defanged is entered on the command-line as a single string.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $OCTET_MAX => 255;
const my $USAGE     => <<END;
Usage:
  perl $0 <ip>
  perl $0

    <ip>    A valid IP address in quad-dotted notation
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 272, Task #1: Defang IP Address (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        my $ip = $ARGV[ 0 ];

        is_valid_ip( $ip ) or error( qq[Invalid IP "$ip"] );

        print qq[Input:  \$ip = "$ip"\n];

        my $defanged = defang( $ip );

        print qq[Output: "$defanged"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub defang
#-------------------------------------------------------------------------------
{
    my ($ip) = @_;

    return $ip =~ s{ \. }{[.]}grx;
}

#-------------------------------------------------------------------------------
sub is_valid_ip
#-------------------------------------------------------------------------------
{
    my ($ip) = @_;

    return 0 unless $ip =~ / ^ [0-9.]+ $ /x;

    my @octets = split / \. /x, $ip;

    return 0 unless scalar @octets == 4;

    for (@octets)
    {
        return 0 unless m/ ^ $RE{num}{int} $ /x && 0 <= $_ <= $OCTET_MAX;
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ip, $expected) = split / \| /x, $line;

        for ($test_name, $ip, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        is_valid_ip( $ip ) or error( qq[Invalid IP "$ip"] );

        my $defanged = defang( $ip );

        is $defanged, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|1.1.1.1    |1[.]1[.]1[.]1
Example 2|255.101.1.0|255[.]101[.]1[.]0

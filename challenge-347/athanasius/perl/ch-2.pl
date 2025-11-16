#!perl

################################################################################
=comment

Perl Weekly Challenge 347
=========================

TASK #2
-------
*Format Phone Number*

Submitted by: Mohammad Sajid Anwar

You are given a phone number as a string containing digits, space and dash only.

Write a script to format the given phone number using the below rules:

  1. Removing all spaces and dashes
  2. Grouping digits into blocks of length 3 from left to right
  3. Handling the final digits (4 or fewer) specially:
     - 2 digits: one block of length 2
     - 3 digits: one block of length 3
     - 4 digits: two blocks of length 2
  4. Joining all blocks with dashes

Example 1

  Input: $phone = "1-23-45-6"
  Output: "123-456"

Example 2

  Input: $phone = "1234"
  Output: "12-34"

Example 3

  Input: $phone = "12 345-6789"
  Output: "123-456-789"

Example 4

  Input: $phone = "123 4567"
  Output: "123-45-67"

Example 5

  Input: $phone = "123 456-78"
  Output: "123-456-78"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A phone number is entered on the command-line as a single string containing
   digits, spaces, and dashes (hyphens) only.

Assumptions
-----------
1. A phone number contains at least 2 digits.
2. Spaces and dashes in a phone number are separators, and so do not occur in
   either initial or final position.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <phone>
  perl $0

    <phone>    A string containing digits, spaces, and dashes only
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 347, Task #2: Format Phone Number (Perl)\n\n";
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
        my ($phone) =  @ARGV;
            $phone  =~ / ^ \d [\d\s-]* \d $ /x
                       or error( 'Invalid phone number' );

        print qq[Input:  \$phone = "$phone"\n];

        my $formatted_num = format_phone_number( $phone );

        print qq[Output: "$formatted_num"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub format_phone_number
#-------------------------------------------------------------------------------
{
    my ($phone) =  @_;
        $phone  =~ / ^ \d [\d\s-]* \d $ /x
                   or die 'Invalid phone number';

    $phone =~ s/ \s //gx;
    $phone =~ s/ \- //gx;

    my @blocks = $phone =~ / (.{1,3}) /gx;

    if (length $blocks[-1] == 1)
    {
        my $ult = \$blocks[-1];
        my $pen = \$blocks[-2];
        my $c   =  substr $$pen, -1, 1, '';
        $$ult   =  $c . $$ult;
    }

    return join '-', @blocks;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $phone, $expected) = split / \| /x, $line;

        for ($test_name, $phone, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $formatted_num = format_phone_number( $phone );

        is $formatted_num, $expected, $test_name;
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
Example 1|1-23-45-6  |123-456
Example 2|1234       |12-34
Example 3|12 345-6789|123-456-789
Example 4|123 4567   |123-45-67
Example 5|123 456-78 |123-456-78

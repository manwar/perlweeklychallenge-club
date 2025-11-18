#!perl

################################################################################
=comment

Perl Weekly Challenge 348
=========================

TASK #2
-------
*Convert Time*

Submitted by: Mohammad Sajid Anwar

You are given two strings, $source and $target, containing time in 24-hour time
form.

Write a script to convert the source into target by performing one of the
following operations:

  1. Add  1 minute
  2. Add  5 minutes
  3. Add 15 minutes
  4. Add 60 minutes

Find the total operations needed to get to the target.

Example 1

  Input: $source = "02:30"
         $target = "02:45"
  Output: 1

  Just one operation i.e. "Add 15 minutes".

Example 2

  Input: $source = "11:55"
         $target = "12:15"
  Output: 2

  Two operations i.e. "Add 15 minutes" followed by "Add 5 minutes".

Example 3

  Input: $source = "09:00"
         $target = "13:00"
  Output: 4

  Four operations of "Add 60 minutes".

Example 4

  Input: $source = "23:45"
         $target = "00:30"
  Output: 3

  Three operations of "Add 15 minutes".

Example 5

  Input: $source = "14:20"
         $target = "15:25"
  Output: 2

  Two operations, one "Add 60 minutes" and one "Add 5 minutes"

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
2. A source time and a target time, both in 24-hour format, are entered on the
   command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <source> <target>
  perl $0

    <source>    Source time in 24-hour format
    <target>    Target time in 24-hour format
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 348, Task #2: Convert Time (Perl)\n\n";
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
    elsif ($argc == 2)
    {
        my  ($source, $target) = @ARGV;

        for ($source, $target)
        {
            / ^ (\d\d) \: (\d\d) $ /x or error( qq[Invalid time "$_"]    );
            0 <= $1 < 24              or error( qq[Invalid hours "$1"]   );
            0 <= $2 < 60              or error( qq[Invalid minutes "$2"] );
        }

        print qq[Input:  \$source = "$source"\n];
        print qq[        \$target = "$target"\n];

        my $operations = convert_time( $source, $target );

        print "Output: $operations\n";
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub convert_time
#-------------------------------------------------------------------------------
{
    my ($source, $target) = @_;

    $source =~ / ^ (\d\d) \: (\d\d) $ /x or die qq[Invalid time "$source"];
    0 <= $1 < 24                         or die qq[Invalid hours "$1"];
    0 <= $2 < 60                         or die qq[Invalid minutes "$2"];

    my $start = ($1 * 60) + $2;

    $target =~ / ^ (\d\d) \: (\d\d) $ /x or die qq[Invalid time "$target"];
    0 <= $1 < 24                         or die qq[Invalid hours "$1"];
    0 <= $2 < 60                         or die qq[Invalid minutes "$2"];

    my $end   = ($1 * 60) + $2;
    my $diff  =  $end - $start;
       $diff += (60 * 24) if $diff < 0;
    my $ops   =  0;

    for my $n (60, 15, 5, 1)
    {
        $ops  += int( $diff / $n );
        $diff %= $n;
    }

    $diff == 0                           or die 'Logic error';

    return $ops;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $source, $target, $expected) = split / \| /x, $line;

        for ($test_name, $source, $target, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $operations = convert_time( $source, $target );

        is $operations, $expected, $test_name;
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
Example 1   |02:30|02:45| 1
Example 2   |11:55|12:15| 2
Example 3   |09:00|13:00| 4
Example 4   |23:45|00:30| 3
Example 5   |14:20|15:25| 2
Same time   |09:17|09:17| 0
One minute  |17:36|17:37| 1
Almost 1 day|17:36|17:35|32

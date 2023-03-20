#!perl

################################################################################
=comment

Perl Weekly Challenge 208
=========================

TASK #2
-------
*Duplicate and Missing*

Submitted by: Mohammad S Anwar

You are given an array of integers in sequence with one missing and one dupli-
cate.

Write a script to find the duplicate and missing integer in the given array.
Return -1 if none found.

For the sake of this task, let us assume the array contains no more than one
duplicate and missing.

Example 1:

  Input: @nums = (1,2,2,4)
  Output: (2,3)

  Duplicate is 2 and Missing is 3.

Example 2:

  Input: @nums = (1,2,3,4)
  Output: -1

  No duplicate and missing found.

Example 3:

  Input: @nums = (1,2,3,3)
  Output: (3,4)

  Duplicate is 3 and Missing is 4.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Error Handling
--------------
1. Input errors abort the script with a Usage message. The following are input
   errors:
    - an element in the input array is not a valid integer
    - the input array is not sorted in monotonically increasing order.

2. Sequence errors produce an output of "-1". If $VERBOSE is set to a true
   value, an error message is also printed (immediately before the output). The
   following are sequence errors:
    - an element is duplicated more than once
    - more than one element is duplicated
    - there is a gap in the sequence of more than one integer
    - there is more than one gap in the sequence.

   If no duplicates are found, this is not an error, but since the output is -1,
   an explanatory note is printed if $VERBOSE is true.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <nums>
  perl $0

    <nums>    An ordered list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 208, Task #2: Duplicate and Missing (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my $nums = parse_command_line();

        printf "Input:  \@nums = (%s)\n", join ',', @$nums;

        my ($dups, $elem) = find_duplicates( $nums );
        my  $output       = -1;

        if    ($dups > 0)
        {
            my $missing = find_missing( $nums );
               $output  = defined $missing ? "($elem,$missing)" : -1;
        }
        elsif ($VERBOSE)
        {
            warn "Note:   No duplicate found\n";
        }

        print "Output: $output\n";
    }
}

#-------------------------------------------------------------------------------
sub find_duplicates
#-------------------------------------------------------------------------------
{
    my ($nums) = @_;
    my (%counts, @dups);

    ++$counts{ $_ } for @$nums;

    for my $num (sort keys %counts)
    {
        my $count = $counts{ $num };

        if    ($count >  2)
        {
            seq_error( qq["$num" is duplicated more than once] );
            return;
        }
        elsif ($count == 2)
        {
            push @dups, $num;
        }
    }

    my $dups  = scalar @dups;

    if ($dups > 1)
    {
        seq_error( 'More than one integer is duplicated' );
        return;
    }

    return ($dups, $dups == 0 ? '' : $dups[ 0 ]);
}

#-------------------------------------------------------------------------------
sub find_missing
#-------------------------------------------------------------------------------
{
    my ($nums) = @_;
    my  $elem  = $nums->[ 0 ];
    my  $count = 0;
    my  $missing;

    for my $i (1 .. $#$nums)
    {
        my $next = $nums->[ $i ];
        my $diff = $next - $elem;

        if    ($diff >  2)
        {
            seq_error( "More than one integer is missing between $elem and " .
                       "and $next" );
            return;
        }
        elsif ($diff == 2)
        {
            $missing = $elem + 1;
            ++$count;
        }

        $elem = $next;
    }

    if ($count > 1)
    {
        seq_error( 'There is more than one gap in the sequence' );
        return;
    }

    return $missing // $nums->[ -1 ] + 1;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $elem =  $ARGV[ 0 ];
       $elem =~ / ^ $RE{num}{int} $ /x
                       or input_error( qq["$elem" is not a valid integer] );

    for my $i (1 .. $#ARGV)
    {
        my $next =  $ARGV[ $i ];
           $next =~ / ^ $RE{num}{int} $ /x
                       or input_error( qq["$next" is not a valid integer] );

        $elem <= $next or input_error( 'The input array is not in sequence' );
        $elem  = $next;
    }

    return [ @ARGV ];
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $expected) = split / \| /x, $line;

        my  @nums         = split / \, /x, $input;
        my ($dups, $elem) = find_duplicates( \@nums );
        my  $got          = -1;

        if ($dups)
        {
            my $missing = find_missing( \@nums );
               $got     = "$elem,$missing";
        }

        is $got, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub input_error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#-------------------------------------------------------------------------------
sub seq_error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    warn "Error:  $message\n" if $VERBOSE;
}

################################################################################

__DATA__
Example 1|1,2,2,4|2,3
Example 2|1,2,3,4|-1
Example 3|1,2,3,3|3,4

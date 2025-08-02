#!perl

################################################################################
=comment

Perl Weekly Challenge 331
=========================

TASK #2
-------
*Buddy Strings*

Submitted by: Mohammad Sajid Anwar

You are given two strings, source and target.

Write a script to find out if the given strings are Buddy Strings.

  If swapping of a letter in one string make them same as the other then they
  are `Buddy Strings`.

Example 1

  Input: $source = "fuck"
         $target = "fcuk"
  Output: true

  The swapping of 'u' with 'c' makes it buddy strings.

Example 2

  Input: $source = "love"
         $target = "love"
  Output: false

Example 3

  Input: $source = "fodo"
         $target = "food"
  Output: true

Example 4

  Input: $source = "feed"
         $target = "feed"
  Output: true

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
2. Two strings are entered on the command-line.

=cut
#===============================================================================

use v5.32;        # Enables strictures
use warnings;
use Const::Fast;
use Devel::Assert qw( on );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <source> <target>
  perl $0

    <source>    First string
    <target>    Second string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 331, Task #2: Buddy Strings (Perl)\n\n";
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
        my ($source, $target) =  @ARGV;

        print qq[Input:  \$source = "$source"\n];
        print qq[        \$target = "$target"\n];

        my $buddies = are_buddies( $source, $target );

        printf "Output: %s\n", $buddies ? 'true' : 'false';
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub are_buddies
#-------------------------------------------------------------------------------
{
    my ($source, $target) = @_;
    my  $result = '';

    if (same_chars( $source, $target ))
    {
        my $diffs = count_diffs( $source, $target );

        $result = $diffs == 0 ? has_duplicates( $source ) :
                  $diffs == 2;
    }

    return $result;
}

#-------------------------------------------------------------------------------
sub same_chars
#-------------------------------------------------------------------------------
{
    my ($source, $target) = @_;
    my  $result = '';

    if (length $source == length $target)
    {
        my $source_norm = join '', sort split '', $source;
        my $target_norm = join '', sort split '', $target;

        $result = $source_norm eq $target_norm;
    }

    return $result;
}

#-------------------------------------------------------------------------------
sub count_diffs
#-------------------------------------------------------------------------------
{
    my ($source, $target) = @_;

    assert length $source == length $target;

    my @source_chars = split '', $source;
    my @target_chars = split '', $target;
    my $differences  = 0;

    for my $i (0 .. $#source_chars)
    {
        ++$differences if $source_chars[ $i ] ne $target_chars[ $i ];
    }

    return $differences;
}

#-------------------------------------------------------------------------------
sub has_duplicates
#-------------------------------------------------------------------------------
{
    my ($string) = @_;
    my  $result  = '';
    my  %char_count;
      ++$char_count{ $_ } for split '', $string;

    for my $count (values %char_count)
    {
        if ($count > 1)
        {
            $result = 1;
            last;
        }
    }

    return $result;
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

        my $buddies = are_buddies( $source, $target ) ? 'true' : 'false';

        is $buddies, $expected, $test_name;
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
Example 1   |fuck|fcuk |true
Example 2   |love|love |false
Example 3   |fodo|food |true
Example 4   |feed|feed |true
Diff lengths|Perl|Pearl|false

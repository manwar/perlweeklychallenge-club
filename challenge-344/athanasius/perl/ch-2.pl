#!perl

################################################################################
=comment

Perl Weekly Challenge 344
=========================

TASK #2
-------
*Array Formation*

Submitted by: Mohammad Sajid Anwar

You are given two list: @source and @target.

Write a script to see if you can build the exact @target by putting these
smaller lists from @source together in some order. You cannot break apart or
change the order inside any of the smaller lists in @source.

Example 1

  Input: @source = ([2,3], [1], [4])
         @target = (1, 2, 3, 4)
  Output: true

  Use in the order: [1], [2,3], [4]

Example 2

  Input: @source = ([1,3], [2,4])
         @target = (1, 2, 3, 4)
  Output: false

Example 3

  Input: @source = ([9,1], [5,8], [2])
         @target = (5, 8, 2, 9, 1)
  Output: true

  Use in the order: [5,8], [2], [9,1]

Example 4

  Input: @source = ([1], [3])
         @target = (1, 2, 3)
  Output: false

  Missing number: 2

Example 5

  Input: @source = ([7,4,6])
         @target = (7, 4, 6)
  Output: true

  Use in the order: [7, 4, 6]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. The elements of @source and @target may be any strings.
2. It must be possible to construct the target using elements from the source,
   but there may be elements of @source which are not used in building @target.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line. The first (the source) comprises
   a non-empty list of non-empty, square-bracket-delimited lists of strings,
   e.g., "[2,3], [1], [4]". The second (the target) comprises a non-empty list
   of strings, e.g., "1, 2, 3, 4". List elements are separated by commas and/or
   whitespace.
   
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

    <source>    Non-empty list of bracket-delimited lists of strings
    <target>    Non-empty list of strings
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 344, Task #2: Array Formation (Perl)\n\n";
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
        my ($source, $target) = parse_input( @ARGV );

        printf "Input:  \@source = (%s)\n",
                join ', ', map { '[' . join( ',', @$_ ) . ']' } @$source;

        printf "        \@target = (%s)\n", join ', ', @$target;

        my $formation = find_array_formation( $source, $target );

        if (scalar @$formation == 0)
        {
            print  "Output: false\n";
        }
        else
        {
            printf "Output: true\n\nUse in the order: %s\n",
                    join ', ', map { '[' . join( ',', @$_ ) . ']' } @$formation;
        }
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_array_formation
#-------------------------------------------------------------------------------
{
    my ($source, $target) = @_;
    my  @source_strs      = map { join '', @$_ } @$source;
    my  $target_str       = join '', @$target;
    my  @formation        = ();
    my  @indices          = ();

    if (recursive_search( \@source_strs, $target_str, \@indices ))
    {
        push @formation, $source->[$_] for @indices;
    }

    return \@formation;
}

#-------------------------------------------------------------------------------
sub recursive_search
#-------------------------------------------------------------------------------
{
    my ($source, $target, $indices) = @_;

    return 1 if $target eq '';

    for my $i (0 .. $#$source)
    {
        my $src = $source->[$i];
        next unless defined $src;

        if ($target =~ / ^ $src .* /x)
        {
            my $new_target     = substr $target, length $src;
            my @new_source     = @$source;
               $new_source[$i] = undef;

            if (recursive_search( \@new_source, $new_target, $indices ))
            {
                unshift @$indices, $i;
                return 1;
            }
        }
    }

    return 0;
}

#-------------------------------------------------------------------------------
sub parse_input
#-------------------------------------------------------------------------------
{
    my ($source_str, $target_str) = @_;

    # Note: characters not contained within square brackets are silently ignored

    my @source = map { [ split / [\s,]+ /x ] } $source_str =~ / \[ (.*?) \] /gx;

    scalar @source > 0   or error( 'The source list is empty' );

    for my $src (@source)
    {
        scalar @$src > 0 or error( 'Empty source list element' );
    }

    my @target = split / [\s,]+ /x, $target_str;

    scalar @target > 0   or error( 'The target list is empty' );

    return \@source, \@target;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $source_str, $target_str, $expected_str) =
             split / \| /x, $line;

        for ($test_name, $source_str, $target_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($source, $target) = parse_input( $source_str, $target_str );
        my  $formation        = find_array_formation( $source, $target );
        my  @expected         = map { [ split /[\s,]+/ ] }
                                $expected_str =~ / \[ (.+?) \] /gx;

        is_deeply $formation, \@expected, $test_name;
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
Example 1|[2 3] [1] [4]                     |1 2 3 4  |[1] [2 3] [4]
Example 2|[1 3] [2 4]                       |1 2 3 4  |
Example 3|[9 1] [5 8] [2]                   |5 8 2 9 1|[5 8] [2] [9 1]
Example 4|[1] [3]                           |1 2 3    |
Example 5|[7 4 6]                           |7 4 6    |[7 4 6]
Surplus  |[2] [x y z] [9 1] [5 2] [5 8] [jk]|5 8 2 9 1|[5 8] [2] [9 1]

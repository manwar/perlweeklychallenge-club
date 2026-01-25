#!perl

################################################################################
=comment

Perl Weekly Challenge 357
=========================

TASK #2
-------
*Unique Fraction Generator*

Submitted by: Yary

Given a positive integer N, generate all unique fractions you can create using
integers from 1 to N and follow the rules below:

  - Use numbers 1 through N only (no zero)
  - Create fractions like numerator/denominator
  - List them in ascending order (from smallest to largest)
  - If two fractions have the same value (like 1/2 and 2/4),
    only show the one with the smallest numerator

Example 1

  Input: $int = 3
  Output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1

Example 2

  Input: $int = 4
  Output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1

Example 3

  Input: $int = 1
  Output: 1/1

Example 4

  Input: $int = 6
  Output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
          4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
          5/2, 3/1, 4/1, 5/1, 6/1

Example 5

  Input: $int = 5
  Output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
          5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive (non-zero) integer is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use bigrat;
use Const::Fast;
use List::Util     qw( uniq );
use Regexp::Common qw( number );
use Test::More;

const my $SCREEN => 80;
const my $USAGE  => <<END;
Usage:
  perl $0 <int>
  perl $0

    <int>    A positive (non-zero) integer
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 357, Task #2: Unique Fraction Generator (Perl)\n\n";
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
        my $int = $ARGV[0];
           $int =~ / ^ $RE{num}{real} $ /x
                    or error( qq["$int" is not a valid integer] );
           $int > 0 or error( "$int is not greater than zero" );

        say "Input:  \$int = $int";

        my $fractions = get_fractions( $int );

        print_fractions( 'Output: ', $fractions );
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub get_fractions
#-------------------------------------------------------------------------------
{
    my ($int) = @_;
    my  @fractions;

    # Note: C-style for loops are needed here, because the range operator ".."
    #       is not overloaded for Math::BigRat.

    for (my $num = 1; $num <= $int; ++$num)
    {
        for (my $den = 1; $den <= $int; ++$den)
        {
            push @fractions, $num / $den;
        }
    }

    @fractions = sort { $a <=> $b } uniq @fractions;

    return \@fractions;
}

#-------------------------------------------------------------------------------
sub print_fractions
#-------------------------------------------------------------------------------
{
    my ($prefix, $fractions) = @_;
    my  $width  = $SCREEN - length $prefix;
    my  $string = join ', ',
                  map { $_->denominator == 1 ? "$_/1" : $_ } @$fractions;
    my  $first  = 1;
    my  $spaces = ' ' x length $prefix;

    while ($string)
    {
        print $first ? $prefix : $spaces;

        $first  =  0;
        $string =~ s/ ^ \s+ //x;

        if (length $string <= $width)
        {
            say $string;
            $string = '';
        }
        else
        {
            my $i = $width;
             --$i until substr( $string, $i, 1 ) eq ' ';

            say substr( $string, 0, $i, '' );
        }
    }
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        while ($line =~ / \\ $ /x)
        {
            chop  $line;
            $line .= <DATA>;
            chomp $line;
        }

        my  ($test_name, $int, $expected_str) = split / \| /x, $line;

        for ($test_name, $int, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $fractions = get_fractions( $int );
        my @expected  = map { $_ + 0 } split / \s+ /x, $expected_str;

        is_deeply $fractions, \@expected, $test_name;
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
Example 1|3|1/3 1/2 2/3 1/1 3/2 2/1 3/1
Example 2|4|1/4 1/3 1/2 2/3 3/4 1/1 4/3 3/2 2/1 3/1 4/1
Example 3|1|1/1
Example 4|6|1/6 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4                                \
            4/5 5/6 1/1 6/5 5/4 4/3 3/2 5/3 2/1                                \
            5/2 3/1 4/1 5/1 6/1
Example 5|5|1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 1/1                            \
            5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1

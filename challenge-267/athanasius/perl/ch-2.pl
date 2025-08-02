#!perl

################################################################################
=comment

Perl Weekly Challenge 267
=========================

TASK #2
-------
*Line Counts*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, and a 26-items array @widths containing the width
of each character from a to z.

Write a script to find out the number of lines and the width of the last line
needed to display the given string, assuming you can only fit 100 width units on
a line.

Example 1

  Input: $str = "abcdefghijklmnopqrstuvwxyz"
         @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,
                    10,10,10,10,10,10)
  Output: (3, 60)

  Line 1: abcdefghij (100 pixels)
  Line 2: klmnopqrst (100 pixels)
  Line 3: uvwxyz (60 pixels)

Example 2

  Input: $str = "bbbcccdddaaa"
         @widths = ( 4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,
                    10,10,10,10,10,10)
  Output: (2, 4)

  Line 1: bbbcccdddaa (98 pixels)
  Line 2: a (4 pixels)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Only lower case letters are allowed in $str.
2. Widths are non-zero positive integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The string $str is entered on the command-line, followed by a list of 26
   positive (non-zero) integer widths.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Devel::Assert  qw( on );
use POSIX          qw( ceil );
use Regexp::Common qw( number );
use Test::More;

const my $LINE_WIDTH => 100;
const my $NUM_CHARS  =>  26;
const my $MID_INDEX  => ceil( $NUM_CHARS / 2 ) - 1;
const my $USAGE      => <<END;
Usage:
  perl $0 <str> [<widths> ...]
  perl $0

    <str>             A string of lowercase letters
    [<widths> ...]    A $NUM_CHARS-item list of character widths
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 267, Task #2: Line Counts (Perl)\n\n";
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
    elsif ($argc == 1 + $NUM_CHARS)
    {
        my ($str, $widths) = parse_command_line();
        my  @first_half    = @$widths[ 0              .. $MID_INDEX ];
        my  @second_half   = @$widths[ $MID_INDEX + 1 .. $#$widths  ];

        print  "Input:  \$str    = $str\n";
        printf "        \@widths = (%s\n", format_widths( \@first_half  );
        printf "                   %s)\n", format_widths( \@second_half );

        my ($lines, $width) = find_line_count( $str, $widths );

        print  "Output: ($lines, $width)\n";
    }
    else
    {
        error( sprintf "Expected 0 or %d command-line arguments, found %d",
                       (1 + $NUM_CHARS), $argc );
    }
}

#-------------------------------------------------------------------------------
sub find_line_count
#-------------------------------------------------------------------------------
{
    my ($str, $widths) = @_;

    assert $str =~ / ^ [a-z]* $ /x;
    assert scalar @$widths == $NUM_CHARS;

    return (0, 0) if $str eq '';

    my $lines = 1;
    my $width = 0;

    for my $char (split //, $str)
    {
        my $units = $widths->[ ord( $char ) - ord( 'a' ) ];

        if ($width + $units > $LINE_WIDTH)
        {
            ++$lines;
            $width  = $units;
        }
        else
        {
            $width += $units;
        }
    }

    return ($lines, $width);
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($str, @widths) = @ARGV;

    $str =~ / ^ [a-z]* $ /x     or error( qq[String "$str" is invalid] );

    assert scalar @widths == $NUM_CHARS;

    for (@widths)
    {
        / ^ $RE{num}{int} $ /x  or error( qq["$_" is not a valid integer] );
    }

    return ($str, \@widths);
}

#-------------------------------------------------------------------------------
sub format_widths
#-------------------------------------------------------------------------------
{
    my ($widths) = @_;

    return join ', ', map { sprintf '%2d', $_ } @$widths;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        while ($line =~ / \\ $ /x)               # Concatenate backslashed lines
        {
            $line  =~ s/ \\ \n //x;
            $line .=  <DATA>;
        }

        chomp $line;

        my  ($test_name, $str, $widths_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $str, $widths_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my  @widths                 = split / \s+ /x, $widths_str;
        my ($lines,     $width)     = find_line_count( $str, \@widths );
        my ($exp_lines, $exp_width) = split / \s+ /x, $exp_str;

        is $lines, $exp_lines, "$test_name: total lines";
        is $width, $exp_width, "$test_name: width of last line";
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
Example 1   |abcdefghijklmnopqrstuvwxyz|                    \
             10 10 10 10 10 10 10 10 10 10 10 10 10         \
             10 10 10 10 10 10 10 10 10 10 10 10 10|3 60
Example 2   |bbbcccdddaaa|                                  \
              4 10 10 10 10 10 10 10 10 10 10 10 10         \
             10 10 10 10 10 10 10 10 10 10 10 10 10|2  4
Empty string||                                              \
              4 10 10 10 10 10 10 10 10 10 10 10 10         \
             10 10 10 10 10 10 10 10 10 10 10 10 10|0  0
Wide chars  |abcdef|                                        \
             99 98 95 87 49 48 10 10 10 10 10 10 10         \
             10 10 10 10 10 10 10 10 10 10 10 10 10|5 97
Narrow chars|abcdefghijklmnopqrstuvwxyz|                    \
              1  1  1  1  1  1  1  1  1  1  1  1  1         \
              1  1  1  1  1  1  1  1  1  1  1  1  1|1 26

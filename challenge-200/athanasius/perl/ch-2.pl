#!perl

###############################################################################
=comment

Perl Weekly Challenge 200
=========================

TASK #2
-------
*Seven Segment 200*

Submitted by: Ryan J Thompson

A seven segment display is an electronic component, usually used to display
digits. The segments are labeled 'a' through 'g' as shown:

    __a__
   |     |
  f|     |b
   |__g__|
   |     |
  e|     |c
   |__d__|


The encoding of each digit can thus be represented compactly as a truth table:

  my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;

For example, $truth[1] = ‘bc’. The digit 1 would have segments ‘b’ and ‘c’
enabled.

Write a program that accepts any decimal number and draws that number as a
horizontal sequence of ASCII seven segment displays, similar to the following:

  -------  -------  -------
        |  |     |  |     |
        |  |     |  |     |
  -------
  |        |     |  |     |
  |        |     |  |     |
  -------  -------  -------

To qualify as a seven segment display, each segment must be drawn (or not
drawn) according to your @truth table.

The number "200" was of course chosen to celebrate our 200th week!

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption
----------
A "decimal" number is a non-negative integer.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $SPACE            => ' ';
const my $HORIZONTAL_BAR   => '-';
const my $VERTICAL_BAR     => '|';
const my $SEVEN_SEG_HEIGHT =>  7;
const my $SEVEN_SEG_WIDTH  =>  7;
const my $SEPARATOR_WIDTH  =>  2;
const my $DIGIT_WIDTH      => $SEVEN_SEG_WIDTH + $SEPARATOR_WIDTH;
const my $SCREEN_WIDTH     => 80;
const my $MAX_LINE_WIDTH   => $SCREEN_WIDTH - ($SCREEN_WIDTH % $DIGIT_WIDTH);
const my @TRUTH_TABLE      =>
         qw( abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg );
const my $USAGE            =>
"Usage:
  perl $0 <decimal>

    <decimal>    A non-negative integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 200, Task #2: Seven Segment 200 (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my  $args = scalar @ARGV;

    if ($args == 1)
    {
        my $decimal =  $ARGV[ 0 ];
           $decimal =~ / ^ $RE{num}{int} $ /x
                or error( qq["$_" is not a valid integer] );

        print  "Input: $decimal\n";
        printf "Output:\n\n%s", draw_number( $decimal );
    }
    else
    {
        error( "Expected 1 argument, found $args" );
    }
}

#------------------------------------------------------------------------------
sub draw_number
#------------------------------------------------------------------------------
{
    my ($decimal) = @_;

    # 1. Draw the display

    my   @lines;
    push @lines, draw_horizontal( $decimal, 'a'      );
    push @lines, draw_vertical  ( $decimal, 'f', 'b' );
    push @lines, draw_horizontal( $decimal, 'g'      );
    push @lines, draw_vertical  ( $decimal, 'e', 'c' );
    push @lines, draw_horizontal( $decimal, 'd'      );

    # 2. Now split long display lines to fit the screen width

    my $display;

    do
    {
        $display .= substr( $lines[ $_ ], 0, $MAX_LINE_WIDTH, '' ) . "\n"
            for 0 .. $#lines;

        $display .= "\n";

    } while (length $lines[ 0 ] > 0);

    chomp  $display;

    return $display;
}

#------------------------------------------------------------------------------
sub draw_horizontal
#------------------------------------------------------------------------------
{
    my ($decimal, $seg) = @_;
    my  $line;

    for my $digit (split //, $decimal)
    {
        my $code =  $TRUTH_TABLE[ $digit ];
        my $char = ($code =~ / $seg /x) ? $HORIZONTAL_BAR : $SPACE;

        $line .= $SPACE x $SEPARATOR_WIDTH . $char x $SEVEN_SEG_WIDTH;
    }

    return $line;
}

#------------------------------------------------------------------------------
sub draw_vertical
#------------------------------------------------------------------------------
{
    my ($decimal, $l_seg, $r_seg) = @_;
    my  $line;

    for my $digit (split //, $decimal)
    {
        my $code   =  $TRUTH_TABLE[ $digit ];
        my $l_char = ($code =~ / $l_seg /x) ? $VERTICAL_BAR : $SPACE;
        my $r_char = ($code =~ / $r_seg /x) ? $VERTICAL_BAR : $SPACE;

        $line .= $SPACE x  $SEPARATOR_WIDTH      . $l_char .
                 $SPACE x ($SEVEN_SEG_WIDTH - 2) . $r_char;
    }

    return ($line, $line);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

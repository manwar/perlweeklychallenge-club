use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption
----------
A "decimal" number is a non-negative integer.

=end comment
#==============================================================================

my Str  constant $SPACE            = ' ';
my Str  constant $HORIZONTAL-BAR   = '-';
my Str  constant $VERTICAL-BAR     = '|';
my UInt constant $SEVEN-SEG-HEIGHT =  7;
my UInt constant $SEVEN-SEG-WIDTH  =  7;
my UInt constant $SEPARATOR-WIDTH  =  2;
my UInt constant $DIGIT-WIDTH      = $SEVEN-SEG-WIDTH + $SEPARATOR-WIDTH;
my UInt constant $SCREEN-WIDTH     = 80;
my UInt constant $MAX-LINE-WIDTH   = $SCREEN-WIDTH -
                                    ($SCREEN-WIDTH % $DIGIT-WIDTH);
my      constant @TRUTH-TABLE      = Array[Str].new:
                 < abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg >;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 200, Task #2: Seven Segment 200 (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $decimal                 #= A non-negative integer
)
#==============================================================================
{
    "Input: $decimal".put;

    "Output:\n\n%s".printf: draw-number( $decimal );
}

#------------------------------------------------------------------------------
sub draw-number( UInt:D $decimal --> Str:D )
#------------------------------------------------------------------------------
{
    # 1. Draw the display

    my Str @lines;

    @lines.push:  draw-horizontal( $decimal, 'a'      );
    @lines.push: |draw-vertical\ ( $decimal, 'f', 'b' );
    @lines.push:  draw-horizontal( $decimal, 'g'      );
    @lines.push: |draw-vertical\ ( $decimal, 'e', 'c' );
    @lines.push:  draw-horizontal( $decimal, 'd'      );

    # 2. Now split long display lines to fit the screen width

    my Str $display;

    repeat
    {
        for 0 .. @lines.end -> UInt $i
        {
            @lines[ $i ] ~~ s/ ^ (. ** { 1 .. $MAX-LINE-WIDTH }) //;

            $display ~= $0.Str ~ "\n";
        }

        $display ~= "\n";

    } while @lines[ 0 ].chars > 0;

    return $display.chomp;
}

#------------------------------------------------------------------------------
sub draw-horizontal( UInt:D $decimal, Str:D $seg --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $line;

    for $decimal.split( '', :skip-empty ) -> Str $digit
    {
        my Str $code =  @TRUTH-TABLE[ $digit.UInt ];
        my Str $char = ($code ~~ / $seg /) ?? $HORIZONTAL-BAR !! $SPACE;

        $line ~= $SPACE x $SEPARATOR-WIDTH ~ $char x $SEVEN-SEG-WIDTH;
    }

    return $line;
}

#------------------------------------------------------------------------------
sub draw-vertical( UInt:D $dec, Str:D $l-seg, Str:D $r-seg --> List:D[Str:D] )
#------------------------------------------------------------------------------
{
    my Str $line;

    for $dec.split( '', :skip-empty ) -> Str $digit
    {
        my Str $code   =  @TRUTH-TABLE[ $digit.UInt ];
        my Str $l-char = ($code ~~ / $l-seg /) ?? $VERTICAL-BAR !! $SPACE;
        my Str $r-char = ($code ~~ / $r-seg /) ?? $VERTICAL-BAR !! $SPACE;

        $line ~= $SPACE x  $SEPARATOR-WIDTH      ~ $l-char ~
                 $SPACE x ($SEVEN-SEG-WIDTH - 2) ~ $r-char;
    }

    return $line, $line;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################

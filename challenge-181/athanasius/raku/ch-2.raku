use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 181
=========================

TASK #2
-------
*Hot Day*

Submitted by: Mohammad S Anwar

You are given file with daily temperature record in random order.

Write a script to find out days hotter than previous day.

Example

  Input File: (temperature.txt)

  2022-08-01, 20
  2022-08-09, 10
  2022-08-03, 19
  2022-08-06, 24
  2022-08-05, 22
  2022-08-10, 28
  2022-08-07, 20
  2022-08-04, 18
  2022-08-08, 21
  2022-08-02, 25

  Output:
  2022-08-02
  2022-08-05
  2022-08-06
  2022-08-08
  2022-08-10

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Note
----
Although, in the example data, the dates (when ordered) form a contiguous
series, the Task description does not require this. I assume that a date whose
previous day is omitted from the data file cannot satisfy the condition that it
be "hotter than [the] previous day". For this reason, the built-in Date class
is used to determine whether a given date has an immediate predecessor in the
given data. This is easier, and less error-prone, than attempting a manual
solution.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 181, Task #2: Hot Day (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D $file where { $file.IO.e }     #= File with daily temperature records
)
#==============================================================================
{
    my Str @lines = $file.IO.lines;

    "Input file ($file):\n%s\n\n".printf: @lines.join: "\n";

    my Int   %temp{Str};
    my regex rxDate { \d ** 4 '-' \d ** 2 '-' \d ** 2 };

    for @lines -> Str $line
    {
        $line ~~ / \s* (<rxDate>) ',' \s+ (\d+) \s* /;

        %temp{ $0.Str } = $1.Int;
    }

    my Str  @dates-str = %temp<>:k.sort;
    my Date @dates-obj = @dates-str.map: { Date.new: $_ };
    my Str  @hotter;

    for 1 .. @dates-str.end -> UInt $i
    {
        if @dates-obj[ $i ] - 1 == @dates-obj[ $i - 1 ] &&
           %temp{ @dates-str[ $i ] } > %temp{ @dates-str[ $i - 1 ] }
        {
            @hotter.push: @dates-str[ $i ];
        }
    }

    "Output:\n%s\n".printf: @hotter.join: "\n";
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

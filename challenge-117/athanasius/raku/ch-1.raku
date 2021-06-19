use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 117
=========================

TASK #1
-------
*Missing Row*

Submitted by: Mohammad S Anwar

You are given text file with rows numbered 1-15 in random order but there is a
catch one row in missing in the file.

 11, Line Eleven
 1, Line one
 9, Line Nine
 13, Line Thirteen
 2, Line two
 6, Line Six
 8, Line Eight
 10, Line Ten
 7, Line Seven
 4, Line Four
 14, Line Fourteen
 3, Line three
 15, Line Fifteen
 5, Line Five

Write a script to find the missing row number.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
1. Create a hash %rows which maps each row number in the range 1 to 15 to a
   count of 0.
2. Read the input file line-by-line, extracting the row number from the begin-
   ning of the line, and increment the %rows count for that row number.
3. 14 of the 15 rows should now have a count of 1. Output the only remaining
   row number with a count of 0.

=end comment
#==============================================================================

my Int constant $MAX-ROW = 15;
my Int constant $ROWS    = $MAX-ROW - 1;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 117, Task #1: Missing Row (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| Text file of ROWS lines, each uniquely numbered in the range 1-MAX-ROW

    Str:D $file where { .IO.f && .IO.s > 0 } = 'Example.txt'
)
#==============================================================================
{
    "Input:  $file".put;

    my Str @lines = $file.IO.lines;

    @lines.elems == $ROWS
        or error( qq[File "$file" does not contain $ROWS lines] );

    my UInt %rows = (1 .. $MAX-ROW).map: { $_ => 0 };

    for 1 .. $ROWS -> UInt $line
    {
        @lines[ $line - 1 ] ~~ / ^ \s* ( \d+ ) /
            or error( "Line $line of the input file is invalid" );

        my UInt $num = $0.Int;

        1 <= $num <= $MAX-ROW
            or error( qq[Invalid number "$num" in line $line] );

        ++%rows{ $num } == 1
            or error( "Found 2 lines numbered $num" );
    }

    my UInt $missing;

    for 1 .. $MAX-ROW -> UInt $row
    {
        $missing = $row, last if %rows{ $row } == 0;
    }

    "Output: $missing".put;
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage ~~ s/  ROWS            /$ROWS/;
    $usage ~~ s/  MAX\-ROW        /$MAX-ROW/;

    $usage.put;
}

##############################################################################

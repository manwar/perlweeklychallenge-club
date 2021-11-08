#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
1. Create a hash %rows which maps each row number in the range 1 to 15 to a
   count of 0.
2. Read the input file line-by-line, extracting the row number from the begin-
   ning of the line, and increment the %rows count for that row number.
3. 14 of the 15 rows should now have a count of 1. Output the only remaining
   row number with a count of 0.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $FILE    => 'Example.txt';
const my $MAX_ROW =>  15;
const my $ROWS    =>  $MAX_ROW - 1;
const my $USAGE   =>
"Usage:
  perl $0 [<file>]

    [<file>]    Text file of $ROWS lines, each uniquely numbered in the " .
                                                          "range 1-$MAX_ROW\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 117, Task #1: Missing Row (Perl)\n\n";
}

#=============================================================================
MAIN:
#==============================================================================
{
    my $file = parse_command_line();

    print "Input:  $file\n";

    my $lines = get_lines( $file );

    scalar @$lines == $ROWS
        or error( qq[File "$file" does not contain $ROWS lines] );

    my %rows = map { $_ => 0 } 1 .. $MAX_ROW;

    for my $line (1 .. $ROWS)
    {
        $lines->[ $line - 1 ] =~ / ^ \s* ( \d+ ) /x
            or error( "Line $line of the input file is invalid" );

        my $num = $1;

        1 <= $num <= $MAX_ROW
            or error( qq[Invalid number "$num" in line $line] );

        ++$rows{ $num } == 1
            or error( "Found 2 lines numbered $num" );
    }

    my $missing;

    for my $row (1 .. $MAX_ROW)
    {
        $missing = $row, last if $rows{ $row } == 0;
    }

    print "Output: $missing\n";
}

#------------------------------------------------------------------------------
sub get_lines
#------------------------------------------------------------------------------
{
    my ($file) = @_;

    open( my $fh, '<', $file )
        or die qq[Cannot open file "$file" for reading, stopped];

    my @lines = <$fh>;

    close $fh
        or die qq[Cannot close file "$file", stopped];

    return \@lines;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args <= 1
            or error( "Expected 0 or 1 command line arguments, found $args" );

    my $file = ($args == 0) ? $FILE : $ARGV[ 0 ];

    open( my $fh, '<', $file )
            or error( qq[Cannot open file "$file" for reading] );

    -s $fh  or error( qq[File "$file" is empty] );
    -f $fh  or error( qq[File "$file" is not a plain file] );
    -T $fh  or error( qq[File "$file" is not a text file] );

    close $fh
            or die qq[Cannot close file "$file", stopped];

    return $file;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

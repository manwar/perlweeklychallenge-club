#!perl

###############################################################################
=comment

Perl Weekly Challenge 110
=========================

TASK #1
-------
*Valid Phone Numbers*

Submitted by: Mohammad S Anwar

You are given a text file.

Write a script to display all valid phone numbers in the given text file.

Acceptable Phone Number Formats

 +nn  nnnnnnnnnn
 (nn) nnnnnnnnnn
 nnnn nnnnnnnnnn

Input File

 0044 1148820341
  +44 1148820341
   44-11-4882-0341
 (44) 1148820341
   00 1148820341

Output

 0044 1148820341
  +44 1148820341
 (44) 1148820341

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption
----------
Following the format of the example input file, each phone number is assumed to
occur on a separate line.

Algorithm
---------
Each of the three valid formats is given its own matching regular expression.
If a given phone number does not match any of these, it is filtered out as
invalid.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $FILE  => './ch-1_Example.txt';
const my $USAGE =>
"Usage:
  perl $0 [<file>]

    [<file>]    Name of input text file (optional)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 110, Task #1: Valid Phone Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $file  = parse_command_line();
    my $count = 0;

    print "Input: $file\n\nOutput:\n\n";

    open(my $fh, '<', $file)
        or die qq[Cannot open file "$file" for reading, stopped];

    while (my $line = <$fh>)
    {
        if (my $number = valid_number( $line ))
        {
            ++$count;
            print "  $number\n";
        }
    }

    close $fh
        or die qq[Cannot close file "$file", stopped];

    print "\n$count valid phone numbers found\n";
}

#------------------------------------------------------------------------------
sub valid_number
#------------------------------------------------------------------------------
{
    my ($line)  = @_;
    my  $number = '';

    if    ($line =~ / ^ \s* \+ (\d{2})    \s+ (\d{10}) \s* $ /x)
    {
        $number = " +$1 $2";
    }
    elsif ($line =~ / ^ \s* \( (\d{2}) \) \s+ (\d{10}) \s* $ /x)
    {
        $number = "($1) $2";
    }
    elsif ($line =~ / ^ \s*    (\d{4})    \s+ (\d{10}) \s* $ /x)
    {
        $number = "$1 $2";
    }

    return $number;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;

    0 <= $args <= 1
             or  error( "Expected 0 or 1 command line arguments, found $args" );

    my $file = ($args == 1) ? $ARGV[0] : $FILE;

    -e $file or  error( qq[File "$file" not found] );
    -z $file and error( qq[File "$file" is empty] );
    -f $file or  error( qq[File "$file" is not a plain file] );

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

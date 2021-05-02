use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption
----------
Following the format of the example input file, each phone number is assumed to
occur on a separate line.

Algorithm
---------
Each of the three valid formats is given its own matching regular expression.
If a given phone number does not match any of these, it is filtered out as
invalid.

=end comment
#==============================================================================

my Str constant $FILE = './ch-1_Example.txt';

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 110, Task #1: Valid Phone Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| Name of input text file (optional)
                                                         # Check that the file:
    Str:D $file where { $file.IO.e &&                    # - exists
                        $file.IO.f &&                    # - is a plain file
                        $file.IO.s > 0 } = $FILE;        # - is not empty
)
#==============================================================================
{
    my UInt $count = 0;

    "Input:  $file\n\nOutput:\n".put;

    for $file.IO.lines -> Str $line
    {
        if my Str $number = valid-number( $line )
        {
            ++$count;
            "  $number".put;
        }
    }

    "\n$count valid phone numbers found".put;
}

#------------------------------------------------------------------------------
sub valid-number( Str:D $line --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $number = '';

    if    $line ~~ / ^ \s* \+ (\d ** 2)    \s+ (\d ** 10) \s* $ /
    {
        $number = " +$0 $1";
    }
    elsif $line ~~ / ^ \s* \( (\d ** 2) \) \s+ (\d ** 10) \s* $ /
    {
        $number = "($0) $1";
    }
    elsif $line ~~ / ^ \s*    (\d ** 4)    \s+ (\d ** 10) \s* $ /
    {
        $number = "$0 $1";
    }

    return $number;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################

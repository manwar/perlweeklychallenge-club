use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 246
=========================

TASK #1
-------
*6 out of 49*

Submitted by: Andreas Voegele

6 out of 49 is a German lottery.

Write a script that outputs six unique random integers from the range 1 to 49.

Output

   3
  10
  11
  22
  38
  49

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
From the sample output, it appears that the selected integers should be display-
ed in ascending numerical order.

=end comment
#===============================================================================

my Int  constant START  =  1;
my Int  constant END    = 49;
my UInt constant SELECT =  6;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 246, Task #1: 6 out of 49 (Raku)\n".put;
}

#===============================================================================
sub MAIN()
#===============================================================================
{
    "Output\n".put;

    my Int @selection = (START .. END).pick( SELECT ).sort: { $^a <=> $^b };

    "  %2d\n".printf: $_ for @selection;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

################################################################################

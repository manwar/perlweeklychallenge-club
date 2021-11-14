use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 134
=========================

TASK #1
-------
*Pandigital Numbers*

Submitted by: Mohammad S Anwar

Write a script to generate first 5 Pandigital Numbers in base 10.

As per the [ https://en.wikipedia.org/wiki/Pandigital_number |wikipedia], it
says:

    A pandigital number is an integer that in a given base has among its
    significant digits each digit used in the base at least once.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
Is zero a "significant" digit?
- if so,  then the base-10            pandigital numbers begin with 1023456789;
- if not, then the base-10 "zeroless" pandigital numbers begin with  123456789.

Since the definition is not specified in the Task description, the solution
below accommodates both definitions. For zeroless pandigitals the script must
be invoked with a --zeroless flag. If no flag is given, the script defaults to
pandigital numbers in which the zero digit is included.

Algorithm
---------
Permutations of the digits are generated in ascending numerical order.

=end comment
#==============================================================================

my UInt constant TARGET = 5;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 134, Task #1: Pandigital Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN( Bool:D :$zeroless = False )
#==============================================================================
{
    ('The first %d pandigital numbers in base 10 containing the digits ' ~
     "%d-9%s:\n\n").printf: TARGET, $zeroless ?? [1, ' (zeroless)'] !! [0, ''];

    my UInt $count  = 0;
    my UInt @digits = $zeroless ?? 1 .. 9 !! 0 .. 9;

    for @digits.permutations -> List $perm
    {
        next if $perm[ 0 ] == 0;

        "    %s\n".printf: $perm.join: '';

        last if ++$count >= TARGET;
    }
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

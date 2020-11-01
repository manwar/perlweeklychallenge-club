use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 084
=========================

Task #1
-------
*Reverse Integer*

Submitted by: Mohammad S Anwar

You are given an integer $N.

Write a script to reverse the given integer and print the result. Print 0 if
the result doesn't fit in 32-bit signed integer.

The number 2,147,483,647 is the maximum positive value for a 32-bit signed
binary integer in computing.

Example 1:

 Input: 1234
 Output: 4321

Example 2:

 Input: -1234
 Output: -4321

Example 3:

 Input: 1231230512
 Output: 0

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my Int constant $MAX =  (2 ** 31) - 1;
my Int constant $MIN = -(2 ** 31);

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 084, Task #1: Reverse Integer (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    Int:D $N                   #= An integer to be reversed
)
##=============================================================================
{
    my Int $n = $N.Int;

    "Input:  $n".put;

    my $reverse = $n.abs.flip;

    if $n < 0
    {
        $reverse *= -1;
        $reverse  =  0 if $reverse < $MIN;
    }
    else
    {
        $reverse  =  0 if $reverse > $MAX;
    }

    print "Output: $reverse\n";
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

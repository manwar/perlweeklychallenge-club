#!perl

################################################################################
=comment

Perl Weekly Challenge 072
=========================

Task #2
-------
*Lines Range*

*Submitted by:* Mohammad S Anwar

You are given a text file name $file and range $A - $B where $A <= $B.

Write a script to display lines range $A and $B in the given file.

*Example*

Input:
    $ cat input.txt
    L1
    L2
    L3
    L4
    ...
    ...
    ...
    ...
    L100

$A = 4 and $B = 12

Output:
    L4
    L5
    L6
    L7
    L8
    L9
    L10
    L11
    L12

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;

const my $USAGE =>
"Usage:
  perl $0 [--file <Str>] [-A <Natural>] [-B <Natural>]

    --file <Str>    The name of a readable text file
    -A <Natural>    Lower bound of range of lines
    -B <Natural>    Upper bound of range of lines: A <= B\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 072, Task #2: Lines Range (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my ($file, $A, $B) = parse_command_line();

    open(my $fh, '<', $file)
        or die "Cannot open file '$file' for reading, stopped";

    my $line_num = 0;

    while (my $line = <$fh>)
    {
        last        if ++$line_num >  $B;
        print $line if   $line_num >= $A;
    }

    close $fh
        or die "Cannot close file '$file', stopped";
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($file, $A, $B);

    GetOptions
    (
        'file=s' => \$file,
        'A=i'    => \$A,
        'B=i'    => \$B,
    )                            or die $USAGE;

    scalar  @ARGV == 0           or die $USAGE;
    defined $file && $file ne '' or die $USAGE;
    defined $A    && $A >   0    or die $USAGE;
    defined $B    && $A <= $B    or die $USAGE;

    return ($file, $A, $B);
}

################################################################################

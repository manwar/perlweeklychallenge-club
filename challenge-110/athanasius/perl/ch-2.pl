#!perl

###############################################################################
=comment

Perl Weekly Challenge 110
=========================

TASK #2
-------
*Transpose File*

Submitted by: Mohammad S Anwar

You are given a text file.

Write a script to transpose the contents of the given file.

Input File

 name,age,sex
 Mohammad,45,m
 Joe,20,m
 Julie,35,f
 Cristina,10,f

Output:

 name,Mohammad,Joe,Julie,Cristina
 age,45,20,35,10
 sex,m,m,f,f

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------
It is assumed that the first line of the input file contains column headers for
the remaining data; it is further assumed that data always appears in this same
order within each line.

It is not specified in the Task description whether the output should be to
screen or to file. To simplify the exercise, output is to the screen only.

Algorithm
---------
Read the column headers into an array, then read the remaining data into a
hash. Read the data back from the hash in the required order (with hash keys
ordered according to their order in the header array).

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $FILE  => './ch-2_Example.txt';
const my $USAGE =>
"Usage:
  perl $0 [<file>]

    [<file>]    Name of input text file (optional)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 110, Task #2: Transpose File (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $file = parse_command_line();

    print "Input: $file\n\n";

    open(my $fh, '<', $file)
        or die qq[Cannot open file "$file" for reading, stopped];

    my    $line = <$fh>;                                 # Header: column names
    chomp $line;
    print "  $line\n";
    my @headers = split /,/, $line;
    my %data    = map { $_ => [ $_ ] } @headers;

    while (my $line = <$fh>)
    {
        chomp $line;
        print "  $line\n";

        my @entries = split /,/, $line;

        push $data{ $_ }->@*, shift @entries for @headers;
    }

    close $fh
        or die qq[Cannot close file "$file", stopped];

    print  "\nOutput:\n\n";
    printf   "  %s\n", join ',', $data{ $_ }->@* for @headers;
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

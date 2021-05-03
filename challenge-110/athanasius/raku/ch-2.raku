use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

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

=end comment
#==============================================================================

my Str constant $FILE = './ch-2_Example.txt';

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 110, Task #2: Transpose File (Raku)\n".put;
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
    "Input: $file\n".put;

    my Str        @headers;
    my Array[Str] %data;
    my Bool       $first = True;

    for $file.IO.lines -> Str $line                   # Note: chomps by default
    {
        if $first                                     # Header: column names
        {
            @headers = $line.split: ',', :skip-empty;
            %data    = @headers.map: { $_ => Array[Str].new( $_ ) };
            $first   = False;
        }
        else                                          # Body:   column values
        {
            my Str @entries = $line.split: ',', :skip-empty;

            %data{ $_ }.push: @entries.shift for @headers;
        }

        "  $line".put;
    }

    "\nOutput:\n".put;
    "  %s\n".printf: %data{ $_ }.join( ',' ) for @headers;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################

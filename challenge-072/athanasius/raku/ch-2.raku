use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

subset Natural of UInt where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 072, Task #2: Lines Range (Raku)\n".put;
}

#===============================================================================
sub MAIN
(
    Str:D     :$file,                   #= The name of a readable text file
    Natural:D :$A,                      #= Lower bound of range of lines
    Natural:D :$B where { $A <= $B },   #= Upper bound of range of lines: A <= B
)
#===============================================================================
{
    $file.IO ~~ :r         or die "ERROR: Cannot open file '$file' for reading";

    my UInt $line-num = 0;

    for $file.IO.lines -> Str $line
    {
        last      if ++$line-num >  $B;
        $line.put if   $line-num >= $A;
    }

=begin comment

    # Alternative syntax using gather, take, and ff

    gather for $file.IO.lines -> Str $line
    {
        $_ = ++$line-num;
        take $line if $A ff $B;

    } .join("\n").put;

=end comment

    CATCH
    {
        default
        {
            .payload.put;
        }
    }
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage ~~ s:g/ \s where \s \{ .*? \} //;
    $usage ~~ s:g/ \> \s+ />    /;
    $usage.put;
}

################################################################################

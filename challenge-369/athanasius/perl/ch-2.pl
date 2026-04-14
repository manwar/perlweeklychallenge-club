#!perl

################################################################################
=comment

Perl Weekly Challenge 369
=========================

TASK #2
-------
*Group Division*

Submitted by: Mohammad Sajid Anwar

You are given a string, group size and filler character.

Write a script to divide the string into groups of given size. In the last group
if the string doesn’t have enough characters remaining fill with the given
filler character.

Example 1

  Input: $str = "RakuPerl", $size = 4, $filler = "*"
  Output: ("Raku", "Perl")

Example 2

  Input: $str = "Python", $size = 5, $filler = "0"
  Output: ("Pytho", "n0000")

Example 3

  Input: $str = "12345", $size = 3, $filler = "x"
  Output: ("123", "45x")

Example 4

  Input: $str = "HelloWorld", $size = 3, $filler = "_"
  Output: ("Hel", "loW", "orl", "d__")

Example 5

  Input: $str = "AI", $size = 5, $filler = "!"
  Output: "AI!!!"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string, a group size, and a filler character are entered on the command-
   line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str> <size> <filler>
  perl $0

    <str>       A string
    <size>      A group size
    <filler>    A filler character
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 369, Task #2: Group Division (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 3)
    {
        my ($str, $size, $filler) = @ARGV;

        $size =~ / ^ $RE{num}{int} $ /x
                            or error( qq["$size" is not a valid integer] );

        $size > 0           or error( "$size is not positive" );

        length $filler == 1 or error( qq["$filler" is not a single character] );

        print qq[Input:  \$str = "$str", \$ize = $size, \$filler = "$filler"\n];

        my $groups = divide_into_groups( $str, $size, $filler );

        printf qq[Output: (%s)\n], join ', ', map { qq["$_"] } @$groups;
    }
    else
    {
        error( "Expected 0 or 3 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub divide_into_groups
#-------------------------------------------------------------------------------
{
    my ($str, $size, $filler) = @_;

    my  @groups = $str =~ / .{$size} /gx;
    my  $mod    = length( $str ) % $size;

    if ($mod > 0)     # Extract the last group and pad it with filler characters
    {
        my $end  = substr $str, (length( $str ) - $mod), $mod;
           $end .= $filler x ($size - $mod);

        push @groups, $end;
    }

    return \@groups;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $size, $filler, $exp_str) = split / \| /x, $line;

        for ($test_name,       $size, $filler, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $groups   = divide_into_groups( $str, $size, $filler );
        my @expected = split / \s+ /x, $exp_str;

        is_deeply $groups, \@expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|RakuPerl|  4|*|Raku Perl
Example 2|Python|    5|0|Pytho n0000
Example 3|12345|     3|x|123 45x
Example 4|HelloWorld|3|_|Hel loW orl d__
Example 5|AI|        5|!|AI!!!

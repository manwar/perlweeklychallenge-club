#!perl

################################################################################
=comment

Perl Weekly Challenge 296
=========================

TASK #1
-------
*String Compression*

Submitted by: Mohammad Sajid Anwar

You are given a string of alphabetic characters, $chars.

Write a script to compress the string with run-length encoding, as shown in the
examples.

A compressed unit can be either a single character or a count followed by a
character.

BONUS: Write a decompression function.

Example 1

  Input: $chars = "abbc"
  Output: "a2bc"

Example 2

  Input: $chars = "aaabccc"
  Output: "3ab3c"

Example 3

  Input: $chars = "abcc"
  Output: "ab2c"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty string of alphabetic characters to be compressed is entered on
   the command-line.

=cut
#===============================================================================

use v5.32;          # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $Alpha => qr/ [A-Za-z] /x;
const my $Digit => qr/ [0-9]    /x;
const my $AlDig => qr/ $Alpha || $Digit /x;
const my $USAGE => <<END;
Usage:
  perl $0 <chars>
  perl $0

    <chars>    A non-empty string of alphabetic characters
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 296, Task #1: String Compression (Perl)\n\n";
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
    elsif ($argc == 1)
    {
        my $chars =  $ARGV[ 0 ];
           $chars =~ / ^ $Alpha+ $ /x or error( 'The input string is invalid' );

        print qq[Input:  \$chars = "$chars"\n];

        my $compressed = compress( $chars );

        print qq[Output: "$compressed"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub compress
#-------------------------------------------------------------------------------
{
    my  ($chars) = @_;
         $chars  =~ / ^ $Alpha+ $ /x                or die "Invalid string: $!";

    my   $compressed = '';
    my   @runs;
    push @runs, $1 while $chars =~ / ( (.) \2* ) /gx;

    for my $run (@runs)
    {
        my $count = length $run;

        $compressed .= $count == 1 ? $run : $count . substr( $run, 0, 1 );
    }

    return $compressed;
}

#-------------------------------------------------------------------------------
sub decompress
#-------------------------------------------------------------------------------
{
    my ($compressed)  =  @_;
        $compressed   =~ / ^ $AlDig+ $Alpha $ /x    or die "Invalid string: $!";
    my  $decompressed =  '';
    my  @runs         = ($compressed =~ / ($Digit* $Alpha) /gx);

    for my $run (@runs)
    {
        $run =~ / ^ ($Digit*) ($Alpha) $ /x;

        $decompressed .= $1 eq '' ? $2 : $2 x $1;
    }

    return $decompressed;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $chars, $expected) = split / \| /x, $line;

        for ($test_name, $chars, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $compressed   =   compress( $chars );
        my $decompressed = decompress( $compressed );

        is $compressed,   $expected, "$test_name: compress";
        is $decompressed, $chars,    "$test_name: decompress";
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
Example 1|abbc   |a2bc
Example 2|aaabccc|3ab3c
Example 3|abcc   |ab2c
No runs  |abcdefg|abcdefg

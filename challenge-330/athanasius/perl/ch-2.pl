#!perl

################################################################################
=comment

Perl Weekly Challenge 330
=========================

TASK #2
-------
*Title Capital*

Submitted by: Mohammad Sajid Anwar

You are given a string made up of one or more words separated by a single space.

Write a script to capitalise the given title. If the word length is 1 or 2 then
convert the word to lowercase otherwise make the first character uppercase and
remaining lowercase.

Example 1

  Input: $str = "PERL IS gREAT"
  Output: "Perl is Great"

Example 2

  Input: $str = "THE weekly challenge"
  Output: "The Weekly Challenge"

Example 3

  Input: $str = "YoU ARE A stAR"
  Output: "You Are a Star"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string made up of one or more words separated by single spaces is entered
   on the command-line.

Assumption
----------
The first word of the title should be title-cased, even if it is only 1 or 2
characters long.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $INPUT_RE => qr/ ^ [A-Za-z]+ (?: [ ] [A-Za-z]+ )* $ /x;
const my $USAGE    => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string made up of one or more words separated by single spaces
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 330, Task #2: Title Capital (Perl)\n\n";
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
        my $str =  $ARGV[ 0 ];
           $str =~ $INPUT_RE or error( 'Invalid input string' );

        print qq[Input: \$str = "$str"\n];

        my $title = capitalise( $str );

        print qq[Output:       "$title"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub capitalise
#-------------------------------------------------------------------------------
{
    my ($str)  =  @_;
        $str   =~ $INPUT_RE or die 'Invalid string';
    my  @words =  split / /, $str;
    my  @title =  tclc( shift @words );

    for my $word (@words)
    {
        push @title, length $word > 2 ? tclc( $word ) : lc $word;
    }

    return join ' ', @title;
}

#-------------------------------------------------------------------------------
sub tclc
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    $str =~ s/ ^ (.) (.*) $ / uc( $1 ) . lc( $2 ) /ex;

    return $str;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $title = capitalise( $str );

        is $title, $expected, $test_name;
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
Example 1 |PERL IS gREAT       |Perl is Great
Example 2 |THE weekly challenge|The Weekly Challenge
Example 3 |YoU ARE A stAR      |You Are a Star
First word|a star IS born      |A Star is Born

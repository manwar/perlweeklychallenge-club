#!perl

################################################################################
=comment

Perl Weekly Challenge 376
=========================

TASK #2
-------
*Doubled Words*

Submitted by: Matt Martini

You are given a string (which may contain embedded newlines) which is taken from
a page on a website. The string will not contain brackets qw{ [ ] }.

Write a script that will find doubled words (such as “this this”) and highlight
(wrap in brackets) each doubled word.

The script should:

  - Work across lines, even finding situations where a word at the end of one
    line is repeated at the beginning of the next.

  - Find doubled words despite capitalization differences, such as with 'The
    the...', as well as allow differing amounts of whitespace (spaces, tabs,
    newlines, and the like) to lie between the words.

  - Find doubled words even when separated by HTML tags. For example, to make a
    word bold: '...it is <B>very</B> very important...'.

  - Only show lines containing doubled words.

Adapted from Mastering Regular Expressions, Third Edition by Jeffrey E. F.
Friedl

Example 1

  Input: $str = "you're given the job of checking the pages on a\nweb server for
                 doubled words (such as 'this this'), a common problem\nwith
                 documents subject to heavy editing."
  Output: "web server for doubled words (such as '[this] [this]'), a common
           problem"

Example 2

  Input: $str = "Find doubled words despite capitalization differences, such as
                 with 'The\nthe...', as well as allow differing amounts of
                 whitespace (spaces,\ntabs, newlines, and the like) to lie
                 between the words."
  Output: "Find doubled words despite capitalization differences, such as with
           '[The]\n[the]...', as well as allow differing amounts of whitespace
           (spaces,"

Example 3

  Input: $str = "to make a word bold: '...it is <B>very</B> very important...'."
  Output: "to make a word bold: '...it is <B>[very]</B> [very] important...'."

Example 4

  Input: $str = "Perl officially stands for Practical Extraction and Report
                 Language, except when it doesn't."
  Output: ""

Example 5

  Input: $str = "There's more than one one way to do it.\nEasy things should be
                 easy and hard things should be possible."
  Output: "There's more than [one] [one] way to do it."

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
2. A string containing no square brackets is entered on the command-line.

Assumptions
-----------
1. If either word has HTML markup, it is recognised as such if, and only if, it
   has the form <X>word</Y>, where X exactly equals Y in a case-sensitive
   comparison.
2. The character sequence "\n" represents an embedded newline in both input and
   output strings.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  Usage:
  perl $0 <str>
  perl $0

    <str>    A string taken from a page on a website, with no square brackets
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 376, Task #2: Doubled Words (Perl)\n\n";
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
        my ($str) = @ARGV;

        valid_str( $str ) or error( 'The input string is invalid' );

        print qq[Input: \$str = "$str"\n];

        my $highlighted =  find_doubled_words( embed_newlines( $str ) );
           $highlighted =~ s/ \n /\\n/gx;  # Print each embedded newline as "\n"

        print qq[\nOutput: "$highlighted"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_doubled_words
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    valid_str( $str ) or die 'Invalid string, stopped';

    # Highlight doubled words, no markup

    $str =~ s{ \b (\w+) (\s+) (\w+) \b (?(?{ lc $1 eq lc $3 })|(*FAIL)) }
             {[$1]${2}[$3]}gx;

    # Highlight doubled words, left word has markup

    $str =~ s{ \< (\w+) \> (\w+) \< \/ \1 \> (\s+) (\w+) \b 
               (?(?{ lc $2 eq lc $4 })|(*FAIL)) }
             {<$1>[$2]</$1>${3}[$4]}gx;

    # Highlight doubled words, right word has markup

    $str =~ s{ \b (\w+) (\s+) \< (\w+) \> (\w+) \< \/ \3 \>
               (?(?{ lc $1 eq lc $4 })|(*FAIL)) }
             {[$1]$2<$3>[$4]</$3>}gx;

    # Highlight doubled words, both words have markup

    $str =~ s{ \< (\w+) \> (\w+) \< \/ \1 \> (\s+) \< (\w+) \> (\w+) \< \/ \4 \>
               (?(?{ lc $2 eq lc $5 })|(*FAIL)) }
             {<$1>[$2]</$1>$3<$4>[$5]</$4>}gx;

    # Remove lines with no highlighting

    $str =~ s/ \n+ /\n/gx;                                  # Remove empty lines
    $str =~ s/ (?: ^ | \n) [^\n\[\]]* (?: \n | $) //gx;

    return $str;
}

#-------------------------------------------------------------------------------
sub valid_str
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    return $str !~ / [\[\]] /x;
}

#-------------------------------------------------------------------------------
sub embed_newlines
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    # Turn each occurrence of the character sequence "\n" into an embedded
    # newline

    return $str =~ s/ \\ n /\n/grx;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        while ($line =~ / \\ $ /x)
        {
            chomp $line;
            $line =~ s/ \s+ \\ $ / /gx;
            $line .= <DATA>;
        }

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $highlighted = find_doubled_words( embed_newlines( $str ) );

        $expected = embed_newlines( $expected );

        is $highlighted, $expected, $test_name;
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
Example 1|you're given the job of checking the pages on a\nweb server for      \
doubled words (such as 'this this'), a common problem\nwith documents subject  \
to heavy editing.|web server for doubled words (such as '[this] [this]'), a    \
common problem
Example 2|Find doubled words despite capitalization differences, such as with  \
'The\nthe...', as well as allow differing amounts of whitespace                \
(spaces,\ntabs, newlines, and the like) to lie between the words.|Find doubled \
words despite capitalization differences, such as with '[The]\n[the]...', as   \
well as allow differing amounts of whitespace (spaces,
Example 3|to make a word bold: '...it is <B>very</B> very important...'.|to    \
make a word bold: '...it is <B>[very]</B> [very] important...'.
Example 4|Perl officially stands for Practical Extraction and Report Language, \
except when it doesn't.|
Example 5|There's more than one one way to do it.\nEasy things should be easy  \
and hard things should be possible.|There's more than [one] [one] way to do it.
Right markup|to highlight a word: '...it is very <mark>very</mark>             \
important...'.|to highlight a word: '...it is [very]                           \
<mark>[very]</mark> important...'.
Left & right|to make bold, then highlight: '...it is <b>very</b>               \
<mark>very</mark> important...'.|to make bold, then highlight: '...it          \
is <b>[very]</b> <mark>[very]</mark> important...'.
Empty line|xxx\n<b>abc</b>\n<i>abc</i>\n\nzzz|<b>[abc]</b>\n<i>[abc]</i>

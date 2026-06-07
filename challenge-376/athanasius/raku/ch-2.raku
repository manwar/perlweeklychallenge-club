use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

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

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 376, Task #2: Doubled Words (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string taken from a page on a website, with no square brackets

    Str:D $str where { !/ <[ \[ \] ]> / }
)
#===============================================================================
{
    qq[Input: \$str = "$str"].put;

    my Str $highlighted =  find-doubled-words( embed-newlines( $str ) );
           $highlighted ~~ s:g/ \n /\\n/;  # Print each embedded newline as "\n"

    qq[\nOutput: "$highlighted"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-doubled-words( Str:D $str where { !/ <[ \[ \] ]> / } --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $hl = $str;

    # Highlight doubled words, no markup

    $hl ~~ s:g{ <|w> (\w+) (\s+) (\w+) <|w>
                <?{ $0.fc eq $2.fc }> } = "[$0]{$1}[$2]";

    # Highlight doubled words, left word has markup

    $hl ~~ s:g{ \<(\w+)\> (\w+) \<\/$0\> (\s+) (\w+) <|w> 
                <?{ $1.fc eq $3.fc }> } = "<$0>[$1]</$0>{$2}[$3]";

    # Highlight doubled words, right word has markup

    $hl ~~ s:g{ <|w> (\w+) (\s+) \<(\w+)\> (\w+) \<\/$2\>
                <?{ $0.fc eq $3.fc }> } = "[$0]{$1}<$2>[$3]</$2>";

    # Highlight doubled words, both words have markup

    $hl ~~ s:g{ \<(\w+)\> (\w+) \<\/$0\> (\s+) \<(\w+)\> (\w+) \<\/$3\>
                <?{ $1.fc eq $4.fc }> } = "<$0>[$1]</$0>{$2}<$3>[$4]</$3>";

    # Remove lines with no highlighting

    $hl ~~ s:g/ \n+ /\n/;                                   # Remove empty lines
    $hl ~~ s:g/ [ ^ || \n ] <-[ \n \[ \] ]>* [ \n || $ ] //;

    return $hl;
}

#-------------------------------------------------------------------------------
sub embed-newlines( Str:D $str --> Str:D )
#-------------------------------------------------------------------------------
{
    # Turn each occurrence of the character sequence "\n" into an embedded
    # newline

    return S:g/ \\ n /\n/ given $str;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: '|';

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $highlighted = find-doubled-words( embed-newlines( $str ) );

        $expected = embed-newlines( $expected );

        is $highlighted, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $data = q:to/END/;
        Example 1|you're given the job of checking the pages on a\nweb server  \
        for doubled words (such as 'this this'), a common problem\nwith        \
        documents subject to heavy editing.|web server for doubled words (such \
        as '[this] [this]'), a common problem
        Example 2|Find doubled words despite capitalization differences, such  \
        as with 'The\nthe...', as well as allow differing amounts of           \
        whitespace (spaces,\ntabs, newlines, and the like) to lie between the  \
        words.|Find doubled words despite capitalization differences, such as  \
        with '[The]\n[the]...', as well as allow differing amounts of          \
        whitespace (spaces,
        Example 3|to make a word bold: '...it is <B>very</B> very              \
        important...'.|to make a word bold: '...it is <B>[very]</B> [very]     \
        important...'.
        Example 4|Perl officially stands for Practical Extraction and Report   \
        Language, except when it doesn't.|
        Example 5|There's more than one one way to do it.\nEasy things should  \
        be easy and hard things should be possible.|There's more than [one]    \
        [one] way to do it.
        Right markup|to highlight a word: '...it is very <mark>very</mark>     \
        important...'.|to highlight a word: '...it is [very]                   \
        <mark>[very]</mark> important...'.
        Left & right|to make bold, then highlight: '...it is <b>very</b>       \
        <mark>very</mark> important...'.|to make bold, then highlight: '...it  \
        is <b>[very]</b> <mark>[very]</mark> important...'.
        Empty line|xxx\n<b>abc</b>\n<i>abc</i>\n\nzzz|<b>[abc]</b>\n<i>[abc]</i>
        END

    return S:g/ \s+ \\ \n \s* / / given $data;
}

################################################################################

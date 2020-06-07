use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 063
=========================

Task #1
-------
*Last Word*

*Submitted by: Mohammad S Anwar*
*Reviewed by: Ryan Thompson*

Define sub last_word($string, $regexp) that returns the last word matching
$regexp found in the given string, or undef if the string does not contain a
word matching $regexp.

For this challenge, a "word" is defined as any character sequence consisting of
non-whitespace characters (\S) only. That means punctuation and other symbols
are part of the word.

The $regexp is a regular expression. Take care that the regexp can only match
individual words! See the *Examples* for one way this can break if you are not
careful.

*Examples*

 last_word('  hello world',                qr/[ea]l/);      # 'hello'
 last_word("Don't match too much, Chet!",  qr/ch.t/i);      # 'Chet!'
 last_word("spaces in regexp won't match", qr/in re/);      #  undef
 last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/); # '399933'

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use Test;

subset Test-Type of Array where [Str, Regex, Str];

my constant TESTS = Array[ Test-Type ].new:
            [ '  hello world',                rx/ <[ea]> l/,        'hello'  ],
            [ "Don't match too much, Chet!",  rx:i/ ch.t /,         'Chet!'  ],
            [ "spaces in regexp won't match", rx:s/in re/,          ''       ],
            [ (1 .. 1e6).join(' '),           rx/ ^ (3 .*?) ** 3 /, '399933' ],
            [ 'I like ripe pies',             rx:i/ i /,            'pies'   ];

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN()
#===============================================================================
{
    "Challenge 063, Task #1: Last Word (Raku)\n".put;

    plan TESTS.elems;

    for  TESTS -> Test-Type $test
    {
        my (Str $string, Regex $regexp, Str $expected) = $test;

        is last_word( $string, $regexp ),
           $expected,
           $expected.chars ?? "Match '$expected'" !! 'No match';
    }
}

#-------------------------------------------------------------------------------
sub last_word( Str:D $string, Regex:D $regexp, --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @words = $string.split: / \s+ /;

    for @words.reverse -> Str $word
    {
        return $word if $word ~~ $regexp;
    }

    return '';
}

################################################################################

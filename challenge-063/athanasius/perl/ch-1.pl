#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my @TESTS =>
         (
             [ '  hello world',                qr/[ea]l/,      'hello'  ],
             [ "Don't match too much, Chet!",  qr/ch.t/i,      'Chet!'  ],
             [ "spaces in regexp won't match", qr/in re/,       undef   ],
             [  join(' ', 1 .. 1e6),           qr/^(3.*?){3}/, '399933' ],
             [ 'I like ripe pies',             qr/i/i,         'pies'   ],
         );

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 063, Task #1: Last Word (Perl)\n\n";

    for my $test (@TESTS)
    {
        my ($string, $regexp, $expected) = @$test;

        is
        (
            last_word( $string, $regexp ),
            $expected,
            defined $expected ? "Match '$expected'" : 'No match'
        );
    }

    done_testing( scalar @TESTS );
}

#-------------------------------------------------------------------------------
sub last_word
#-------------------------------------------------------------------------------
{
    my ($string, $regexp) = @_;

    my @words = split / \s+ /x, $string;

    for my $word (reverse @words)
    {
        return $word if $word =~ $regexp;
    }

    return;
}

################################################################################

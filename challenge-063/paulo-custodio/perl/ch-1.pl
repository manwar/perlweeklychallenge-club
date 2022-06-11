#!/usr/bin/env perl

# Challenge 063
#
# TASK #1 › Last Word
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
#
# Define sub last_word($string, $regexp) that returns the last word matching
# $regexp found in the given string, or undef if the string does not contain a
# word matching $regexp.
#
# For this challenge, a “word” is defined as any character sequence consisting
# of non-whitespace characters (\S) only. That means punctuation and other
# symbols are part of the word.
#
# The $regexp is a regular expression. Take care that the regexp can only match
# individual words! See the Examples for one way this can break if you are not
# careful.
#
# Examples
# last_word('  hello world',                qr/[ea]l/);      # 'hello'
# last_word("Don't match too much, Chet!",  qr/ch.t/i);      # 'Chet!'
# last_word("spaces in regexp won't match", qr/in re/);      #  undef
# last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/); # '399933'

use Modern::Perl;
use Test::More;

is last_word('  hello world',                qr/[ea]l/),        'hello';
is last_word("Don't match too much, Chet!",  qr/ch.t/i),        'Chet!';
is last_word("spaces in regexp won't match", qr/in re/),        undef;
is last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/),   '399933';
done_testing;

sub last_word {
    my($text, $re) = @_;
    my @words = split(' ', $text);
    for (reverse @words) {
        return $_ if /$re/;
    }
    return;
}

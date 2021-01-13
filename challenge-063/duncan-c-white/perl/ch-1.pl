#!/usr/bin/perl
#
# Task 1: "Last Word
#
# Define sub last_word($string, $regexp) that returns the last word
# matching $regexp found in the given string, or undef if the string does
# not contain a word matching $regexp.
# 
# For this challenge, a "word" is defined as any character sequence
# consisting of non-whitespace characters (\S) only. That means punctuation
# and other symbols are part of the word.
# 
# The $regexp is a regular expression. Take care that the regexp can only
# match individual words! See the Examples for one way this can break if
# you are not careful.
# 
# Examples
# 
# last_word('  hello world',                qr/[ea]l/);      # 'hello'
# last_word("Don't match too much, Chet!",  qr/ch.t/i);      # 'Chet!'
# last_word("spaces in regexp won't match", qr/in re/);      #  undef
# last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/); # '399933'
# "
# 
# My notes: cool question. Will have a go!
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;

die "Usage: last-word REGEX PHRASE\n" unless @ARGV>1;

my $regex = shift;
my $phrase = join(' ', @ARGV);

$regex = qr/$regex/o;

#
# my $lastword = lastword( $string, $regex );
#	Split $string into (whitespace separated) words
#	and then find and return the last of those words
#	which match the given $regex.  Return undef if
#	no word matches.
#
fun lastword( $string, $regex )
{
	foreach my $word (reverse(split(/\s+/, $string)))
	{
		return $word if $word =~ $regex;
	}
	return undef;
}

my $lastword = lastword( $phrase, $regex );
say $lastword // "undefined";

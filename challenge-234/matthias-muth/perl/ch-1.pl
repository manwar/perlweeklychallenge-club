#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 234 Task 1: Common Characters
#
#       Perl solution by Matthias Muth.
#
#	Call this script using
#	    $ ch-1.pl
#	or
#	    $ ch-1.pl -v
#	to get more output.
#

use v5.20;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use lib '.';
use TestExtractor;

use List::Util qw( all );

sub common_characters_1( @words ) {
    # Produce a count of available characters for each word.
    my @available_chars;
    for my $i ( 0..$#words ) {
	++$available_chars[$i]{$_}
	    for split //, $words[$i];
    }
    vsay pp \@available_chars;

    # For each possible result character (cannot be more than the characters
    # in $word[0]) check whether all words have at least one of that character
    # available. Decrease its availability count in each word.
    return
	grep {
	    my $char = $_;
	    all { ( $available_chars[$_]{$char}-- // 0 ) > 0 } 1..$#words
	} split //, $words[0];
}

sub common_characters( @words ) {
    my @sorted_words = map join( "", sort split //, $_ ), @words;
    my @result_chars= split //, $sorted_words[0];
    for ( @sorted_words[1..$#sorted_words] ) {
	my $re = join " ", map "(?:(?!$_)[a-$_])* ($_?)", @result_chars;
	@result_chars = grep $_ ne "", /^$re/x;
    }
    my %freq;
    ++$freq{$_}
	for @result_chars;
    return grep { $freq{$_}-- // 0 > 0 } split //, $words[0];
}

run_tests;

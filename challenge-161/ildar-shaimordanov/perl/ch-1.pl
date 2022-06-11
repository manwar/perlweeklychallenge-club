#!/usr/bin/env perl

use strict;
use warnings;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-161/
#
# Task 1: Abecedarian Words
# Submitted by: Ryan J Thompson
#
# An abecedarian word is a word whose letters are arranged in alphabetical
# order. For example, “knotty” is an abecedarian word, but “knots”
# is not. Output or return a list of all abecedarian words in the
# dictionary, sorted in decreasing order of length.

# =========================================================================

# The version using regex

# The same approach as one-liner
# perl -nle 'BEGIN { $A = join "", "a".."z" } $a = $A; ( $w = $_ ) =~ s/(.)\1*/$a =~ s#.*$1## ? "" : $&/eg; $w or print'

my $A = join "", "a".."z";

while ( <> ) {
	my $a = $A;

	chomp( my $word = $_ );

	$word =~ s/(.)\1*/ $a =~ s|.*$1|| ? "" : $& /eg;

	$word or print;
}

# =========================================================================

# The version using split/sort/join

# The same approach as one-liner
# perl -nle '( join "", sort split // ) eq $_ && print'

#while ( <> ) {
#	chomp( my $word = $_ );
#	my $sorted = join '', sort split //, $word;
#	$sorted eq $word && print;
#}

# =========================================================================

# EOF

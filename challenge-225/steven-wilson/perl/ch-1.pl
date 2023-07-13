#!/usr/bin/env perl

use 5.12.0;

sub max_words {
    my $max;
    for (@_) {
        my @words = split / /, $_;
	if ( scalar @words > $max ) {
	    $max = scalar @words;
        }
    }
    return $max;
}

say max_words("Perl and Raku belong to the same family.",
	"I love Perl.",
	"The Perl and Raku Conference.");
say max_words("The Weekly Challenge.",
	"Python is the most popular guest language.",
	"Team PWC has over 300 members.");


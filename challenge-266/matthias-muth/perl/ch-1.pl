#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 266 Task 1: Uncommon Words
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub uncommon_words( $line1, $line2 ) {
    my @all_words = "$line1 $line2" =~ /(\w+)/g;
    my %word_counts;
    ++$word_counts{$_}
	for @all_words;
    my @results = grep $word_counts{$_} == 1, @all_words;
    return @results ? @results : "";
}

use Test2::V0 qw( -no_srand );
is [ uncommon_words( "Mango is sweet", "Mango is sour" ) ], [ "sweet", "sour" ],
    'Example 1: uncommon_words( "Mango is sweet", "Mango is sour" ) == ("sweet", "sour")';
is [ uncommon_words( "Mango Mango", "Orange" ) ], [ "Orange" ],
    'Example 2: uncommon_words( "Mango Mango", "Orange" ) == "Orange"';
is [ uncommon_words( "Mango is Mango", "Orange is Orange" ) ], [ "" ],
    'Example 3: uncommon_words( "Mango is Mango", "Orange is Orange" ) == ""';
done_testing;

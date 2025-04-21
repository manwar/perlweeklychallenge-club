#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 317 Task 1: Acronyms
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub acronyms( $array, $word ) {
    return join( "", map /^(.)/, $array->@* ) eq $word
}

# Here's a version with a 'real' regex...
sub acronyms_2( $array, $word ) {
    my $all_words = join " ", $array->@*;
    return join( "", $all_words =~ /((?<=(?:^|\s))\S)/g ) eq $word;
}

use Test2::V0 qw( -no_srand );

is acronyms( ["Perl", "Weekly", "Challenge"], "PWC" ), T,
    'Example 1: acronyms( ["Perl", "Weekly", "Challenge"], "PWC" ) is true';
is acronyms( ["Bob", "Charlie", "Joe"], "BCJ" ), T,
    'Example 2: acronyms( ["Bob", "Charlie", "Joe"], "BCJ" ) is true';
is acronyms( ["Morning", "Good"], "MM" ), F,
    'Example 3: acronyms( ["Morning", "Good"], "MM" ) is false';

done_testing;

#!/usr/bin/env perl

use v5.36;
use List::Util qw( max );

sub max_words (@sentences) {
    max( map( scalar( $_ = () = $_ =~ /\b(\s)\b/g ), @sentences ) ) + 1;
}

#| Run test cases
sub MAIN() {
    use Test2::V0 qw( is plan );
    plan 2;

    is max_words(
        "Perl and Raku belong to the same family.",
        "I love Perl.",
        "The Perl and Raku Conference."
      ),
      8, 'works for first sentence list';
    is max_words(
        "The Weekly Challenge.",
        "Python is the most popular guest language.",
        "Team PWC has over 300 members."
      ),
      7, 'works for second sentence list';
}

MAIN();

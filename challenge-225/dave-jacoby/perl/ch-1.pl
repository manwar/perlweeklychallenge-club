#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (
    [
        "Perl and Raku belong to the same family.",
        "I love Perl.",
        "The Perl and Raku Conference."
    ],
    [
        "The Weekly Challenge.",
        "Python is the most popular guest language.",
        "Team PWC has over 300 members."
    ]
);

for my $example (@examples) {
    my $max   = max_words( $example->@* );
    my $input = join ",\n\t\t", map { qq{"$_"} } $example->@*;
    say <<~"END";
    Input: \@list = ($input)
    Output: $max
    END
}

sub max_words ( @list ) {
    my $max = 0;
    for my $sentence (@list) {
        my @sentence = split /\ /, $sentence;
        my $length   = scalar @sentence;
        $max = $length > $max ? $length : $max;
    }
    return $max;
}

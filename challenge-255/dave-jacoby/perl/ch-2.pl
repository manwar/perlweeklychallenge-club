#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ max };

my @examples = (

    {
        paragraph =>
            "Joe hit a ball, the hit ball flew far after it was hit.",
        word => "hit",
    },
    {
        paragraph =>
"Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.",
        word => "the",
    }
);

for my $example (@examples) {
    my $output = most_frequent_word($example);
    my $p = $example->{paragraph};
    my $w = $example->{word};

    say <<~"END";
    Input:  \$p = "$p"
            \$w = "$w"
    Output: "$output"
    END
}

sub most_frequent_word ($obj) {
    my $paragraph   = $obj->{paragraph};
    my $banned_word = $obj->{word};
    my %hash;

    # some people REALLY hate map being used in this way, believing
    # that it should end in (start with) @array = , but clearly, 
    # I disagree
    map { $hash{$_}++ }
        grep { $_ ne $banned_word }
        split /\W+/, $paragraph;
    my $max = max values %hash;
    my @output = 
        grep { $hash{$_} == $max } keys %hash;
    return shift @output;
}

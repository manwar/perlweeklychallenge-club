#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ bitwise fc postderef say signatures state };

use List::Util qw{max};

my @examples = (

    {
        sentence => "Perl Weekly Challenge",
        keys     => [ 'l', 'a' ]
    },
    {
        sentence => "Perl and Raku",
        keys     => ['a']
    },
    {
        sentence => "Well done Team PWC",
        keys     => [ 'l', 'o' ]
    },
    {
        sentence => "The joys of polyglottism",
        keys     => ['T']
    },
);

for my $example (@examples) {
    my $output   = broken_keys($example);
    my $sentence = $example->{sentence};
    my $keys     = join ',', map { qq{'$_'} } $example->{keys}->@*;

    say <<~"END";
        Input:  \$sentence = "$sentence", \@keys = ($keys)
        Output: $output
END
}

sub broken_keys ($obj) {
    my $output   = 0;
    my $sentence = $obj->{sentence};
    my @sentence = split /\W+/, $sentence;
    my @keys     = $obj->{keys}->@*;
OUTER: for my $word (@sentence) {
        for my $key (@keys) {
            next OUTER if $word =~ /$key/mix;
        }
        $output++;
    }
    return $output;
}

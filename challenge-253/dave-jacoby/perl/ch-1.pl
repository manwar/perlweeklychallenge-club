#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum0 };

my @examples = (

    {
        words     => [ "one.two.three", "four.five", "six" ],
        separator => ".",
    },
    {
        words     => [ '$perl$$', '$$raku$' ],
        separator => '$',
    },
    {
        words     => [qw{abracadabra}],
        separator => 'a',
    },
    {
        words     => [qw{Splits the string EXPR into a list of strings}],
        separator => 'i',
    }
);

for my $example (@examples) {
    my $input     = join ', ', map { qq{"$_"} } $example->{words}->@*;
    my @output    = split_strings($example);
    my $separator = $example->{separator};
    my $output    = join ', ', map { qq{"$_"} } @output;

    say <<~"END";
    Input:  \@words = ($input)
            \$separator = "$separator"
    Output: $output

    END
}

sub split_strings ($hash) {
    my $sep    = quotemeta( $hash->{separator} );
    my @words  = $hash->{words}->@*;
    my @output = grep { length $_ } map { split /$sep/, $_ } @words;
    return @output;
}

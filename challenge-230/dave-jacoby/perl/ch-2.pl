#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw( uniq );

my @examples = (

    {
        words  => [ "pay", "attention", "practice", "attend" ],
        prefix => "at"
    },
    {
        words  => [ "janet", "julia", "java", "javascript" ],
        prefix => "ja"
    },
);

for my $e (@examples) {
    my $prefix = $e->{prefix};
    my @input  = $e->{words}->@*;
    my $input = join ', ', map {qq{"$_"}} @input;
    my $output = count_words($e);
    say <<~"END";
    Input:  \@words = ($input)
            \$prefix = "$prefix"
    Output: $output
    END
}

sub count_words ($ref) {
    my $prefix = $ref->{prefix};
    return scalar grep { $_ =~ /^$prefix/ } $ref->{words}->@*;
}

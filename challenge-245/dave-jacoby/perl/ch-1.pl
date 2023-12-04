#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    {
        lang       => [ 'perl', 'c', 'python' ],
        popularity => [ 2,      1,   3 ],
    },
    {
        lang       => [ 'c++', 'haskell', 'java' ],
        popularity => [ 1,     3,         2 ],
    },
);

for my $e (@examples) {
    my @output     = sort_language($e);
    my $output     = join ', ', map { qq{'$_'} } @output;
    my $lang       = join ', ', map { qq{'$_'} } $e->{lang}->@*;
    my $popularity = join ', ', $e->{popularity}->@*;

    say <<~"END";
    Input:  \@lang = ($lang)
            \@popularity = ($popularity)
    Output: ($output)
    END
}

sub sort_language ($input) {
    return map { $_->[1] }
        sort { $a->[0] <=> $b->[0] }
        map  { [ $input->{popularity}->[$_], $input->{lang}->[$_] ] }
        0 .. -1 + scalar $input->{lang}->@*;
}

#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ bitwise fc postderef say signatures state };

use List::Util qw{max};

my @examples = (

    'and2 Raku3 cousins5 Perl1 are4',
    'guest6 Python1 most4 the3 popular5 is2 language7',
    'Challenge3 The1 Weekly2',
);

for my $example (@examples) {
    my $output = sort_string($example);
    say <<"END";
    Input:  \$str = "$example"
    Output: $output
END
}

sub sort_string ($input) {
    my @output;
    my @input = split /\s+/, $input;
    for my $x (@input) {
        my ( $word, $i ) = $x =~ m{(\S+)(\d+)$};
        $output[$i] = $word;
    }
    @output = grep {defined} @output;
    return join ' ', @output;

}

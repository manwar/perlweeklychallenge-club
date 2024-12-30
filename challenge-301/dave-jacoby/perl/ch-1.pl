#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use Algorithm::Permute;
my @examples = (

    [ 20, 3 ],
    [ 3,  30, 34, 5, 9 ],
);

for my $example (@examples) {
    my $input  = join ', ', $example->@*;
    my $output = largest_number( $example->@* );
    say <<"END";
    Input:  \$int = ($input)
    Output: $output
END
}

sub largest_number (@array) {
    my $p = Algorithm::Permute->new( \@array );
    my $l = 0;
    while ( my @p = $p->next() ) {
        my $n = join '', @p;
        $l = $l < $n ? $n : $l;
    }
    return $l;
}

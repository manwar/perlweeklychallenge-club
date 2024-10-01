#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ uniq };

my @examples = (

    [ 5, 6, 4, 1 ],
    [ 4, 5 ],
    [ 1, 2, 2, 3 ],

);

for my $example (@examples) {
    my $output = third_maximum( $example->@* );
    my $input  = join ', ', $example->@*;
    say <<"END";
    Input:  \$ints = ($input)
    Output: $output
END
}

sub third_maximum (@array) {
    my @new = reverse uniq sort @array;
    return $new[2] if defined $new[2];
    return shift @new;
}


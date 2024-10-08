#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ uniq };

my @examples = (

    [ 6, 2, 3, 3 ],
    [ 3, 1, 4, 13 ],
    [ 2, 1, 4, 2 ],
    [ 1, 1, 0 ],
    [ 1, 1, 0, 0 ],
);

# [ 1, 1, 0 ] is false, because 1 isn't 2 * 0
# [ 1, 1, 0, 0 ] is true, because 0 is 2 * 0

for my $example (@examples) {
    my $output = doubles_exist( $example->@* );
    my $input  = join ', ', $example->@*;
    say <<"END";
    Input:  \$ints = ($input)
    Output: $output
END
}

sub doubles_exist (@array) {
    for my $i ( 0 .. -1 + scalar @array ) {
        for my $j ( 0 .. -1 + scalar @array ) {
            next if $i == $j;
            my ( $ii, $jj ) = map { $array[$_] } $i, $j;
            return 'true' if $ii == 2 * $jj;
        }
    }
    return 'false';
}

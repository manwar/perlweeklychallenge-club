#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    [ -3, -2, -1, 1, 2, 3 ],
    [ -2, -1, 0,  0, 1 ],
    [ 1,  2,  3,  4 ],
);

for my $example (@examples) {
    my $str    = join ', ', $example->@*;
    my $output = max_count( $example->@* );
    say <<"END";
    Input:  \$str = ($str)
    Output: $output
END
}

sub max_count(@ints) {
    my $pos = scalar grep { $_ > 0 } @ints;
    my $neg = scalar grep { $_ < 0 } @ints;
    return $pos > $neg ? $pos : $neg;
}

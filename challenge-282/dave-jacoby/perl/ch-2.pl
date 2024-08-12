#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @examples = (    # added a couple test entries

    qw{ pPeERrLl rRr GoO }
);

for my $input (@examples) {
    my $output = changing_keys($input);
    say <<"END";
    Input:  \$str = "$input"
    Output: $output
END
}

sub changing_keys ($input) {
    my $c   = 0;
    my $len = -1 + length $input;
    for my $i ( 1 .. $len ) {
        my $l = fc substr $input, $i - 1, 1;
        my $t = fc substr $input, $i, 1;
        $c++ if $l ne $t;
    }
    return $c;
}

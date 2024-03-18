#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use DateTime;
use List::Util qw{ uniqint  };

my @examples = (

    [ 1,  2, 2, 1, 1, 3 ],
    [ 1,  2, 3 ],
    [ -2, 0, 1, -2, 1, 1, 0, 1, -2, 9 ],
);

for my $example (@examples) {
    my @ints   = $example->@*;
    my $ints   = join ',', @ints;
    my $output = unique_occurances(@ints);
    say <<"END";
    Input:  \$ints = ($ints)
    Output: $output
END
}

sub unique_occurances (@ints) {
    my %hash;
    for my $i (@ints) {
        $hash{$i}++;
    }

    # is there a more clever way to do this?
    my $before = scalar values %hash;
    my $after  = uniqint values %hash;
    return $before == $after ? 1 : 0;
}

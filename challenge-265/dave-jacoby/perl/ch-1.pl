#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc postderef say signatures state };

my @examples = (

    [ 1, 2, 3, 3, 3, 3, 4, 2 ],
    [ 1, 1 ],
    [ 1, 2, 3 ],
    [ 1, 2, 3, 5 ],
);

for my $example (@examples) {
    my $output = appearance(@$example);
    $output //= 'undef';
    my $input = join ',', @$example;
    say <<"END";
    Input:  \$ints = ($input)
    Output: $output
END
}

sub appearance (@ints) {
    my @output;
    my %hash;
    my $max = scalar @ints;
    map { $hash{$_}++ } @ints;
    for my $k ( sort { $a <=> $b } keys %hash ) {
        my $v = $hash{$k};
        my $p = 100 * $v / $max;
        next if $p < 33;
        push @output, $k;
    }
    return scalar @output ? shift @output : undef;
}

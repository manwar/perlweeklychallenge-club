#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ postderef say signatures state };

use List::Util qw{ uniq };

my @examples = (    # added a couple test entries

    [ 2, 2, 3, 4 ],
    [ 1, 2, 2, 3, 3, 3 ],
    [ 1, 1, 1, 3 ],

);

for my $example (@examples) {
    my $input  = join ', ', $example->@*;
    my $output = lucky_integer($example);
    say <<"END";
    Input:  \@int = ($input)
    Output: $output
END
}

sub lucky_integer ($input) {
    my %hash;
    map { $hash{$_} ++ } $input->@*;
    my @lucky = reverse sort grep { $hash{$_} == $_ } keys %hash;
    return shift @lucky if scalar @lucky;
    return -1;
}

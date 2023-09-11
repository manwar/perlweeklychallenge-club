#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ uniq };

my @examples = (

    [ 1,  1, 2,  2, 2, 3 ],
    [ 2,  3, 1,  3, 2 ],
    [ -1, 1, -6, 4, 5, -6, 1, 4, 1 ],
);

for my $e (@examples) {
    my @ints   = $e->@*;
    my $ints   = join ',', @ints;
    my @output = frequency_sort(@ints);
    my $output = join ',', @output;
    say <<~"END";
    Input:  \@ints = ($ints)
    Output: ($output)
    END
}

sub frequency_sort (@ints) {
    my @uniq = uniq sort @ints;
    my %hash;
    for my $i (@uniq) {
        $hash{$i} = scalar grep { $_ eq $i } @ints;
    }

    return map {
        my $x = $_;
        map { $x } 1 .. $hash{$_}
        }
        sort { $hash{$a} <=> $hash{$b} }
        sort { $b        <=> $a } @uniq;
}

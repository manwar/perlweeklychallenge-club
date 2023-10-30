#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Algorithm::Permute;
use List::Util qw{ sum0 };

my @examples = (

    [ 1, 1, 1, 1, 1 ],
    [ 1, 3, 5, 2, 1, 3, 1 ],
    [ 1, 2, 3, 4 ],
);

for my $e (@examples) {
    my @nums   = $e->@*;
    my $nums   = join ', ', @nums;
    my $output = maximise_greatness(@nums);
    say <<~"END";
    Input:  \@nums = 
        ($nums)
    Output: $output
    END
}

sub maximise_greatness (@nums) {
    my $max = 0;
    my $top = -1 + scalar @nums;
    my $copy;
    $copy->@* = @nums;
    my $p = Algorithm::Permute->new($copy);
    while ( my @perm = $p->next ) {
        my $great = sum0 map { $nums[$_] < $perm[$_] ? 1 : 0 } 0 .. $top;
        $max = $great > $max ? $great : $max;
    }
    return $max;
}

#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    [ [ 3, 2, 1, 4 ], [ 1, 2, 3, 4 ], ],
    [
        [ 1, 3, 4 ],
        [ 4, 1, 3 ],
    ],
    [
        [2],
        [2],
    ],

);

for my $example (@examples) {
    my $source = join ', ', $example->[0]->@*;
    my $target = join ', ', $example->[1]->@*;
    my $output = reverse_equals($example);
    say <<"END";
        Input:  \@source = ($source)
                \@target = ($target)
        Output: $output
END
}

sub reverse_equals ($obj) {
    my @source = $obj->[0]->@*;
    my @target = $obj->[1]->@*;
    my $s      = join ' ', @source;
    my $t      = join ' ', @target;
    return 'true' if $s eq $t;

    for my $i ( 0 .. $#source ) {
        for my $j ( $i + 1 .. $#source ) {
            my @copy = map { $_ } @source;
            $copy[$i] = $source[$j];
            $copy[$j] = $source[$i];
            my $t    = join ' ', @target;
            my $c    = join ' ', @copy;
            return 'true' if $c eq $t;
        }
    }

    return 'false';
}

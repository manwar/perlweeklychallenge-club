#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc postderef say signatures state };

use List::Util qw{ uniq any };

my @examples = (

    [ [ 3, 7, 5 ], [ 9, 5, 7 ], ],
    [ [ 1, 2, 1 ], [ 5, 4, 4 ], ],
    [ [2], [5], ],
);

for my $example (@examples) {
    my $output = find_magic_number(@$example);
    my $x      = join ',', $example->[0]->@*;
    my $y      = join ',', $example->[1]->@*;
    say <<"END";
    Input:  \@x = ($x)
            \@y = ($y)
    Output: $output
END
}

sub find_magic_number (@arrays) {
    my ( $x, $y ) = @arrays;
    my %hash;
    my %o;
    my @n;
    for my $v ( $x->@* ) {
        my @o = map { abs $v - $_ } $y->@*;
        $hash{$v}->@* = @o;
        push @n, @o;
    }
    for my $v ( uniq sort @n ) {
        my $c = 0;
        for my $k ( keys %hash ) {
            $c++ if any { $v == $_ } $hash{$k}->@*;
        }
        $o{$v} = $c;
    }
    my @o = sort { $o{$b} <=> $o{$a} } keys %o;
    return shift @o;
}

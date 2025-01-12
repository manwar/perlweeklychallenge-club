#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ first max uniq };
use Carp;

my @examples = (

    [ 3, 4, 2 ],
    [ 2, 2, 3, 3, 3, 4 ],
    [qw{ 1 1 1 2 2 2 3 3 3 4 4 4 5 5}],
);

for my $example (@examples) {
    my $ints   = join ', ', $example->@*;
    my $output = delete_and_earn( $example->@* );
    say <<"END";
    Input:  \@ints = ($ints)
    Output: $output
END
}

sub delete_and_earn (@array) {
    my @output;
    for my $i ( uniq sort @array ) {
        push @output, _delete_and_earn( $i, 0, @array );
    }
    return max @output;
}

sub _delete_and_earn ( $n, $v, @array ) {
    my @output;
    $v += $n;
    @array = grep { $_ != $n - 1 } @array;
    @array = grep { $_ != $n + 1 } @array;
    my $i = first { $array[$_] == $n } 0 .. -1 + scalar @array;
    $array[$i] = undef;
    @array = grep { defined } @array;
    if ( !scalar @array ) {
        return $v;
    }
    for my $nn ( uniq sort @array ) {
        push @output, _delete_and_earn( $nn, $v, @array );
    }
    return max @output;
}


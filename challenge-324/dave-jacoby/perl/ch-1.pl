#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    { r => 2, c => 2, ints => [ 1, 2, 3, 4 ] },
    { r => 1, c => 3, ints => [ 1, 2, 3 ] },
    { r => 4, c => 1, ints => [ 1, 2, 3, 4 ] },
);

for my $example (@examples) {
    my $r      = $example->{r};
    my $c      = $example->{c};
    my $ints   = join ', ', $example->{ints}->@*;
    my @output = two_d_array($example);
    my $output = join ', ', map { qq{[$_]} }
        map { join ', ', $_->@* } @output;
    say <<"END";
    Input:  \@ints = ($ints),
            \$r = $r,
            \$c = $c
    Output: ($output)
END
}

sub two_d_array($example) {
    my @output;
    my $r    = $example->{r};
    my $c    = $example->{c};
    my @ints = $example->{ints}->@*;
    my $rr   = my $cc = 0;
    for my $i (@ints) {
        $output[$rr][$cc] = $i;
        $cc++;
        if ( $cc >= $c ) {
            $cc = 0;
            $rr++;
        }
    }
    return wantarray ? @output : \@output;
}


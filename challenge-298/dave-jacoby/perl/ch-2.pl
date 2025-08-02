#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{min max};

my @examples = (

    [ [ 3, 4 ], [ 2, 3 ], [ 1, 2 ] ],
    [ [ 1, 4 ], [ 2, 3 ], [ 3, 4 ] ],
    [ [ 1, 2 ] ],
    [ [ 1, 4 ], [ 2, 2 ], [ 3, 4 ] ],
);

for my $example (@examples) {
    my @output = right_interval( $example->@* );
    my $output = join ', ', @output;
    my $input  = join ', ', map { qq{[$_]} }
        map { join ', ', $_->@* } $example->@*;
    say <<"END";
    Input:  \@intervals = ($input)
    Output: ($output)
END
}

sub right_interval (@intervals) {
    my @output;
    my $c    = 0;
    my @strs = map { join ',', $_->@* } @intervals;
    my %strs = map { $_ => $c++ } @strs;
    return (-1) if scalar @intervals < 2;

    for my $index ( 0 .. -1 + scalar @intervals ) {
        my $i = $intervals[$index];
        my @local;
        for my $j (@intervals) {
            my $ii = join ',', $i->@*;
            my $jj = join ',', $j->@*;
            my $in = $strs{ join ',', $i->@* };
            my $jn = $strs{ join ',', $j->@* };
            next unless $j->[0] >= $i->[1];
            push @local, [ $j->@* ];
        }
        @local = sort { $a->[0] <=> $b->[0] } @local;
        push @output,
            defined $local[0] ? $strs{ join ',', $local[0]->@* } : -1;
        push @intervals, $i;
    }
    return @output;
}

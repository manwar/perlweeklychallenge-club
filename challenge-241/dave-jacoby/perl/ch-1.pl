#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    { nums => [ 0, 1, 4, 6, 7, 10 ], diff => 3, },
    { nums => [ 4, 5, 6, 7, 8, 9 ],  diff => 2, }
);

for my $e (@examples) {
    my $output = triplets($e);
    my $nums   = join ', ', map { qq{"$_"} } $e->{nums}->@*;
    my $diff   = $e->{diff};
    say <<~"END";
    Input:  \@nums = ($nums)
            \$diff = "$diff"
    Output: $output
    END
}

sub triplets ($input) {
    my $c    = 0;
    my @nums = $input->{nums}->@*;
    my $diff = $input->{diff};
    my $end  = -1 + scalar @nums;
    for my $i ( 0 .. $end ) {
        my $ii = $nums[$i];
        for my $j ( $i + 1 .. $end ) {
            my $jj = $nums[$j];
            for my $k ( $j + 1 .. $end ) {
                my $kk = $nums[$k];
                next unless $jj - $ii == $diff;
                next unless $kk - $jj == $diff;
                $c++;
            }
        }
    }
    return $c;
}

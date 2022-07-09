package main;
use strict;
use warnings;
use Statistics::Descriptive;

sub get_five_nums_summary {
    my @what = @_;

    my $stat = Statistics::Descriptive::Full->new();
    $stat->add_data(@what);

    my $sum = 0;

    # min
    $sum += $stat->quantile(0);

    #max
    $sum += $stat->quantile(4);

    #median
    my $median = $stat->quantile(2);
    $sum += $median;

    # lower quartile
    $stat->clear;
    $stat->add_data( grep { $_ < $median } @what );
    $sum += $stat->quantile(2);

    # higher quartile
    $stat->clear;
    $stat->add_data( grep { $_ > $median } @what );
    $sum += $stat->quantile(2);

    return $sum;
}

use Test::More;

is( get_five_nums_summary( ( 0, 0, 1, 2, 63, 61, 27, 13 ) ), 115 );
done_testing;
1;

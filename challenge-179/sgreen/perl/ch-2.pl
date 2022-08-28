#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';
use List::Util qw(min max);

sub main (@numbers) {
    my @bar      = (qw'▁ ▂ ▃ ▄ ▅ ▆ ▇ █');
    my $barcount = scalar(@bar);

    my $mn        = min(@numbers);
    my $mx        = max(@numbers);
    my $extent    = $mx - $mn;
    my $sparkline = '';

    foreach my $n (@numbers) {
        $sparkline .= $bar[ min( $barcount - 1, int( ( $n - $mn ) / $extent * $barcount ) ) ];
    }

    say $sparkline;
}

main(@ARGV);
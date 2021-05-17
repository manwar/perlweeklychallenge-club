#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util 'sum';

sub main {
    my $string = shift;

    # Calculate the sum of all digits
    my $sum = sum( $string =~ /(\d+)/g );
    $string =~ s/(\d+)/$sum-$1/eg;
    say $string;

}

main(@ARGV);

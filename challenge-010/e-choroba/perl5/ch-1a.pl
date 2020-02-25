#!/usr/bin/perl
use warnings;
use strict;

use lib '../../../challenge-047/e-choroba/perl';
use MyRoman qw{ to_roman from_roman };

use Test::More;

my %test = (XXXIX     => 39,
            CCXLVI    => 246,
            DCCLXXXIX => 789,
            MMCDXXI   => 2421,
            CLX       => 160,
            CCVII     => 207,
            MIX       => 1009,
            MLXVI     => 1066,
            MDCCLXXVI => 1776,
            MCMIII    => 1903,  # MDCDIII
            MCMX      => 1910,
            MCMLIV    => 1954,
            MCMXCIX   => 1999, # MIM
            MMXIX     => 2019,
            MMMCMXCIX => 3_999);

for my $roman (keys %test) {
    is from_roman($roman), $test{$roman};
}

for my $roman (keys %test) {
    is to_roman($test{$roman}), $roman;
}

is from_roman('MIM'), 1999;
is from_roman('MDCDIII'), 1903;

done_testing();

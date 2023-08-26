#!/usr/bin/env perl
use strict;
use warnings;

use List::Util qw(sum);

sub count_senior_citizens {
    my @passengers = @_;
    my $count = grep { $_ >= 60 } map { /(\d{10}[MF])(\d{2})/; $2 } @passengers;
    return $count;
}

use Test::More;

subtest 'count_senior_citizens' => sub {
    is(count_senior_citizens("7868190130M7522","5303914400F9211","9273338290F4010"), 2, "Example 1");
    is(count_senior_citizens("1313579440F2036","2921522980M5644"), 0, "Example 2");
};

done_testing();

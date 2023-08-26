#!/usr/bin/env perl

use 5.12.0;
use Test2::V0 -no_srand;

is( senior_citizens( ( "7868190130M7522", "5303914400F9211", "9273338290F4010" ) ), 2, "Example 1" );
is( senior_citizens( ( "1313579440F2036", "2921522980M5644" ) ), 0, "Example 2" );
done_testing();

sub senior_citizens {
    my @elements = @_;
    my @ages     = grep { $_ >= 60 } map { $_ =~ m/(\d{2})\d{2}$/ } @elements;
    return scalar @ages;
}

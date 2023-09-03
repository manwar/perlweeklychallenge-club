# The Weekly Challenge 231
# Task 2 Senior Citizens
use v5.30.0;
use warnings;

sub sc {
    my @list = @_;
    my $ans = grep { $_ >= 60} map {substr($_, 11, 2)} @list;
    return $ans;
}

use Test::More tests => 2;
ok sc("7868190130M7522","5303914400F9211","9273338290F4010") == 2;
ok sc("1313579440F2036","2921522980M5644") == 0;

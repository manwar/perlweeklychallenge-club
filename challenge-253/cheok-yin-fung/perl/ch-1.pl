# The Weekly Challenge 253
# Task 1 Split Strings
use v5.30.0;
use warnings;

sub ss {
    my @arr = $_[0]->@*;
    my $sep = $_[1];
    my $Sep = $sep;
    $Sep =~ s/(\W)/\\$1/g;
    my @new = grep {$_} split /$Sep/, join $sep, @arr;
    return [@new];
}

use Test2::V0;
is ss(["one.two.three","four.five","six"], "."), ["one", "two", "three", "four","five", "six"];
is ss(['$perl$$', '$$raku$'], '$'), ["perl", "raku"];
done_testing();

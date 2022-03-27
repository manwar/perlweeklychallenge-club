#!/usr/bin/perl
# The Weekly Challenge 157
# Task 1 Pythagorean Means
use v5.22.0;
use warnings;
use List::Util qw/sum product/;

if (defined($ARGV[0])) {
    my @in = @ARGV;
    my %ans = %{mean(@in)};
    say "AM = ", sprintf("%.1f", $ans{a});
    say "GM = ", sprintf("%.1f", $ans{g});
    say "HM = ", sprintf("%.1f", $ans{h});
}



sub mean {
    my @n = @_;
    my %mean = (
        "a" => (sum @n) / scalar @n,
        "g" => exp(log(product @n)/ scalar @n),
        "h" => (scalar @n)/(sum map {1/$_} @n),
    );
    return \%mean;
}



use Test::More tests => 3;
is_deeply(
    [sort {$b<=>$a} map {sprintf("%.1f", $_)} values mean(1,3,5,6,9)->%*],
    [4.8, 3.8, 2.8],
    "Example 1"
);
is_deeply(
    [sort {$b<=>$a} map {sprintf("%.1f", $_)} values mean(2,4,6,8,10)->%*],
    ["6.0", 5.2, 4.4],
    "Example 2"
);
is_deeply(
    [sort {$b<=>$a} map {sprintf("%.1f", $_)} values mean(1,2,3,4,5)->%*],
    ["3.0", 2.6, 2.2],
    "Example 3"
);

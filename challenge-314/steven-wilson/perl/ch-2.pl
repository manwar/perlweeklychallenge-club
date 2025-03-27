#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;
use List::Util qw/zip/;
use Array::Compare;

my $comp = Array::Compare->new;

sub sortColumns{
    my @strings = @_;
    my $count = 0;
    my @strings_split = map { [split //, $_] } @strings;
    for my $c (zip(@strings_split)){
        my @sorted = sort @$c;
        if (!$comp->compare($c, \@sorted)) {
            $count++;
        }
    }
    return $count;
}

is(sortColumns("swpc", "tyad", "azbe"), 2, "Example 1");
is(sortColumns("cba", "daf", "ghi"), 1, "Example 2");
is(sortColumns("a", "b", "c"), 0, "Example 3");

done_testing();

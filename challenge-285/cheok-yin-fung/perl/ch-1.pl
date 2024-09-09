# The Weekly Challenge 285
# Task 1 No Connection
use v5.30;
use warnings;
use List::Util qw/uniqstr/;

sub nc {
    my @routes = $_[0]->@*;
    my %dest;
    my @places;
    for my $route (@routes) {
        $dest{$route->[0]} = $route->[1];
        push @places, $route->[0], $route->[1];
        @places = uniqstr @places;
    }
    for my $p (@places) {
        return $p if !defined($dest{$p})
    }
}

use Test::More tests=>2;
ok nc([["B","C"],["D","B"],["C","A"]]) eq "A";
ok nc([["A","Z"]]) eq "Z";

use strict;
use warnings;
use feature 'say';

sub no_connection {
    my %starts = map { $_->[0] => 1} @_;
    my @ends = map { $_->[1] } @_;
    return grep {not exists $starts{$_}} @ends;
}

my @tests = ([["B","C"], ["D","B"], ["C","A"]], [["A","Z"]]);
for my $test (@tests) {
    printf "%-20s => ", join " ", map {"(@{$test->[$_]})"}
        0..scalar @$test - 1;
    say no_connection @$test;
}

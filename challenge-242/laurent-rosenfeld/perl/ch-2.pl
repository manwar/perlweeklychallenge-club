use strict;
use warnings;
use feature 'say';

sub stringify_matrix {
    my @in = @_;
    my $out = "";
    $out .=  "(@$_) " for @in;
    return $out;
}

sub flip_matrix {
    my @in = @_;
    my @out;
    for my $row (@in) {
        my @rev = reverse @$row;
        push @out, [map { $_ eq '0' ? 1 : 0 } @rev];
    }
    return @out;
}
for my $test ([[<1 1 0>], [<0 1 1>], [<0 0 1>]],
    [[<1 1 0>], [<1 0 1>], [<0 0 0>]],
    [[<1 1 0 0>], [<1 0 0 1>], [<0 1 1 1>], [<1 0 1 0>]]) {
    print stringify_matrix @$test;
    say " => ", stringify_matrix flip_matrix @$test;
}

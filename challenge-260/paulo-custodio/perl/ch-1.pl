#!/usr/bin/env perl

use Modern::Perl;

my @ints = @ARGV;
say uniq_occurences(@ints);

sub uniq_occurences {
    my(@ints) = @_;
    my %count;
    $count{$_}++ for @ints;
    my %uniq;
    for (values %count) {
        return 0 if $uniq{$_}++;
    }
    return 1;
}

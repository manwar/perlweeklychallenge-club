#!/usr/bin/env perl
use Modern::Perl;
use experimental qw(signatures);
use Test::More;

sub ch1 ($str) {
    # find integers
    my @integers = ($str =~ /(\d+)/g);

    # remove duplicates
    my %seen;
    return (
        grep { !$seen{$_}++ }
        @integers
    );
}


is_deeply([ch1('the1weekly2challenge2')], [1, 2]);
is_deeply([ch1('the1weekly2challenge2and1')], [1, 2]);
is_deeply([ch1('the1weekly2challenge2more3')], [1, 2, 3]);
is_deeply([ch1('go21od1lu5c7k')], [21, 1, 5, 7]);
is_deeply([ch1('4p3e2r1l')], [4, 3, 2, 1]);

done_testing();

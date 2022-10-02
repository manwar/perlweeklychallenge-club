#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @paths = qw(
    /a/b/c/1/x.pl
    /a/b/c/d/e/2/x.pl
    /a/b/c/d/3/x.pl
    /a/b/c/4/x.pl
    /a/b/c/d/5/x.pl
);

my $common_path = get_common_path(@paths);
say $common_path;

sub get_common_path( @paths) {
    my @first = split /\//mx, $paths[0];
    my $d = scalar @paths;
    my $last_path = '/';
    for my $i ( 0 .. -1 + scalar @first ) {
        my $p = join '/', @first[ 0 .. $i ];
        my $c = scalar grep { m{^$p}mx } @paths;
        if ( $c !~ $d ) {
            return $last_path;
        }
        $last_path = $p;
    }

}
